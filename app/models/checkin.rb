class Checkin < ActiveRecord::Base
  belongs_to :user

  scope :reposted, lambda { where(:reposted => true) }
  scope :mirrored, lambda { where("mirror_checkin_id IS NOT NULL") }
  scope :unmirrored, lambda { where("mirror_checkin_id IS NULL") }

  def mirrored?
    !mirror_checkin_id.blank?
  end

  def time
    Time.at(timestamp)
  end

  def time_in_offset_location
    if user.offset_location
      time - (user.offset_location.time_offset.to_i).hours
    else
      nil
    end
  end

  def venue_url
    "http://foursquare.com/venue/#{venue_id}"
  end

  def latlng
    [lat,lng]
  end

  def latlng_string
    "#{lat}, #{lng}"
  end

  def relative_lat
    if user.origin_location
      lat - user.origin_location.lat
    else
      nil
    end
  end

  def relative_lng
    if user.origin_location
      lng - user.origin_location.lng
    else
      nil
    end
  end

  private

  def self.create_for_user_from_mashie(user,mashie, initial=false)
    unless user.checkins.where(:checkin_id => mashie.id).any?
      if mashie.venue
        # TODO: we need to model Venues, maybe? Certainly extract latlong for
        # venues from the JSON.
        venue_id = mashie.venue.id
        venue_name = mashie.venue.name
        category_id_list = mashie.venue.categories.map {|cat| cat.id}.join(",")
        category_name_list = mashie.venue.categories.map {|cat| cat.name}.join(",")
        lat = mashie.venue.location.lat
        lng = mashie.venue.location.lng
      else
        # TODO: what sort of checkins don't have location?
        venue_id, venue_name = nil,nil
        lat, lng = nil,nil
      end

      user.checkins.create(:checkin_id => mashie.id,
                           :timezone_offset => mashie.timeZoneOffset,
                           :timestamp => mashie.createdAt,
                           :shout => mashie.shout,
                           :lat => lat,
                           :lng => lng,
                           :venue_id => venue_id,
                           :venue_name => venue_name,
                           :category_id_list => category_id_list,
                           :category_name_list => category_name_list,
                           :reposted => initial)
    end
  end

end
