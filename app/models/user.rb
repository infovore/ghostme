class User < ActiveRecord::Base
  require 'addressable/uri'
  require 'open-uri'

  has_many :checkins

  def name
    "#{firstname} #{lastname}"
  end

  def all_foursq_checkins
    foursquare = Foursquare::Base.new(access_token)
    foursquare.users.find('self').all_checkins
  end

  def all_foursq_checkins_since(timestamp)
    all_foursq_checkins("afterTimestamp" => timestamp.to_s)
  end

  def next_checkin_after(t)
    checkins.where("timestamp >= #{t.to_i}").first
  end
end
