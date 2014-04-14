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

  def all_foursq_checkins(args = {})
    foursquare = GhostClient.foursquare_client(access_token)

    checkin_list = []
    per_page = 250
    offset = 0
    continue = true

    while continue
      next_checkins = foursquare.user_checkins({:limit => per_page, :offset => offset}.merge(args))
      
      checkin_list = checkin_list + next_checkins.items

      if next_checkins.items.size < per_page
        continue = false
      end

      offset = offset + per_page
    end

    checkin_list
  end

  def all_foursq_checkins_since(timestamp)
    all_foursq_checkins(:afterTimestamp => timestamp.to_s)
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

  def photo_url(size_string="small")
    case size_string
    when 'tiny'
      size = "36x36"
    when 'small'
      size = "100x100"
    when 'medium'
      size = "300x300"
    when 'large'
      size = "500x500"
    when 'original'
      size = 'original'
    end
    photo_prefix + size + photo_suffix
  end
end
