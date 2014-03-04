class CheckinCreator
  def self.create_at_mirror_for_checkin_id(id)
    checkin = Checkin.find(id)
    if checkin && !checkin.mirrored?
      user = checkin.user
      secondary_foursquare = Foursquare::Base.new(:access_token => user.secondary_access_token)

      mirror_venue = VenueMirrorer.mirror_venue_for_checkin(checkin)

      if mirror_venue
        mirrored_checkin = secondary_foursquare.checkins.create("venueId" => mirror_venue['id'], :shout => checkin.shout)
        if mirrored_checkin
          checkin.mirror_checkin_id = mirrored_checkin.id
          checkin.reposted = true
          checkin.scheduled = false
          checkin.save
        end
      else
        #raise "No Mirror venue found."
      end
    else
      #raise "No Checkin matching that ID found"
    end
  end

  def self.schedule_at_mirror_for_checkin_id(id)
    checkin = Checkin.find(id)
    if checkin 
      user = checkin.user
      offset_time = user.offset_location.time_offset
      if offset_time < 0
        time_delta = 0 - offset_time
        new_time = Time.at(checkin.timestamp) + time_delta.hours
        if new_time > Time.now
          self.delay_until(new_time).create_at_mirror_for_checkin_id(id)
          checkin.scheduled = true
          checkin.save
        end
      else
        self.delay.create_at_mirror_for_checkin_id(id)
      end

    end
  end
end
