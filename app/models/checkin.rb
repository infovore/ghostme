class Checkin < ActiveRecord::Base
  belongs_to :user

  scope :reposted, :conditions => {:reposted => true}

  def time
    Time.at(timestamp)
  end

  def echo_time
    Time.at(timestamp) + 1.year
  end

  def venue_url
    "http://foursquare.com/venue/#{venue_id}"
  end

  private

  def self.create_for_user_from_json(user,json)
    unless user.checkins.where(:checkin_id => json['id']).any?
      if json['venue']
        # TODO: we need to model Venues, maybe? Certainly extract latlong for
        # venues from the JSON.
        venue_id = json['venue']['id']
        venue_name = json['venue']['name']
      else
        # TODO: what sort of checkins don't have location?
        venue_id, venue_name = nil,nil
      end

      user.checkins.create(:checkin_id => json['id'],
                           :timezone => json['timeZone'],
                           :timestamp => json['createdAt'],
                           :shout => json['shout'],
                           :venue_id => venue_id,
                           :venue_name => venue_name)
    end
  end
end
