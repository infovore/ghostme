class CheckinCreator
  def self.create_at_mirror_for_checkin_id(id)
    checkin = Checkin.find(id)
    if checkin && !checkin.mirrored?
      user = checkin.user
      secondary_foursquare = Foursquare::Base.new(user.secondary_access_token)

      mirror_venue = VenueMirrorer.mirror_venue_for_checkin(checkin)

      if mirror_venue
        mirrored_checkin = secondary_foursquare.checkins.create("venueId" => mirror_venue['id'], :shout => checkin.shout)
        if mirrored_checkin
          checkin.mirror_checkin_id = mirrored_checkin.id
          checkin.save
        end
      else
        #raise "No Mirror venue found."
      end
    else
      #raise "No Checkin matching that ID found"
    end
  end
end
