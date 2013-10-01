class CheckinCreator
  def self.create_at_mirror_for_checkin_id(id)
    checkin = Checkin.find(id)
    if checkin
      user = checkin.user
      secondary_foursquare = Foursquare::Base.new(user.secondary_access_token)

      mirror_venue = VenueMirrorer.mirror_venue_for_checkin(checkin)

      if mirror_venue
        secondary_foursquare.checkins.create("venueId" => mirror_venue['id'], :shout => checkin.shout)
      else
        raise "No Mirror venue found."
      end
    else
      raise "No Checkin matching"
    end
  end
end
