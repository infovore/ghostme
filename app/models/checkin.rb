class Checkin < ActiveRecord::Base
  belongs_to :user

  scope :reposted, lambda { where(:reposted => true) }

  def mirrored?
    !mirror_checkin_id.blank?
  end

  def time
    Time.at(timestamp)
  end

  def echo_time
    Time.at(timestamp) + 1.year
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

  def self.create_for_user_from_json(user,json)
    unless user.checkins.where(:checkin_id => json['id']).any?
      if json['venue']
        # TODO: we need to model Venues, maybe? Certainly extract latlong for
        # venues from the JSON.
        venue_id = json['venue']['id']
        venue_name = json['venue']['name']
        category_id_list = json['venue']['categories'].map {|cat| cat['id']}.join(",")
        category_name_list = json['venue']['categories'].map {|cat| cat['name']}.join(",")
        lat = json['venue']['location']['lat']
        lng = json['venue']['location']['lng']
      else
        # TODO: what sort of checkins don't have location?
        venue_id, venue_name = nil,nil
        lat, lng = nil,nil
      end

      user.checkins.create(:checkin_id => json['id'],
                           :timezone => json['timeZone'],
                           :timestamp => json['createdAt'],
                           :shout => json['shout'],
                           :lat => lat,
                           :lng => lng,
                           :venue_id => venue_id,
                           :venue_name => venue_name,
                           :category_id_list => category_id_list,
                           :category_name_list => category_name_list)
    end
  end
end
