class User < ActiveRecord::Base
  require 'addressable/uri'
  require 'open-uri'

  has_many :checkins
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id', :validate => true
  belongs_to :origin_location, :class_name => 'Location', :foreign_key => 'origin_location_id'
  belongs_to :offset_location, :class_name => 'Location', :foreign_key => 'offset_location_id'

  accepts_nested_attributes_for :origin_location
  accepts_nested_attributes_for :offset_location

  def checkins_since_signup
    signup_timestamp = self.created_at.to_i
    checkins.where("timestamp > ?", signup_timestamp)
  end

  def name
    "#{firstname} #{lastname}"
  end

  def origin?
    !origin_location.nil?
  end

  def offset?
    !offset_location.nil?
  end

  def all_foursq_checkins
    foursquare = Foursquare::Base.new(access_token)
    foursquare.users.find('self').all_checkins
  end

  def all_foursq_checkins_since(timestamp)
    foursquare = Foursquare::Base.new(access_token)
    foursquare.users.find('self').checkins(:afterTimestamp => timestamp.to_s)
  end

  def next_checkin_after(t)
    checkins.where("timestamp >= #{t.to_i}").first
  end

  def configuration_state
    if access_token && secondary_access_token && origin_location && offset_location
      "complete"
    elsif access_token && secondary_access_token
      "locations_needed"
    elsif access_token
      "secondary_access_token_needed"
    end
  end
end
