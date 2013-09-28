class User < ActiveRecord::Base
  require 'addressable/uri'
  require 'open-uri'

  has_many :checkins

  def name
    "#{firstname} #{lastname}"
  end

  def origin?
    origin_lat && origin_lng && origin_name
  end

  def origin_latlng
    [origin_lat, origin_lng]
  end

  def origin_latlng_string
    if origin_lat && origin_lng
      "#{origin_lat}, #{origin_lng}"
    else
      ""
    end
  end

  def update_origin_latlng_from_string(string)
    if string.split(",").size == 2
      lat,lng = string.split(",").map(&:strip)
      self.origin_lat = lat
      self.origin_lng = lng
    else
      raise "Too many components for a latlng."
    end
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
end
