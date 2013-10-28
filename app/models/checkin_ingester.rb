class CheckinIngester

  def self.ingest_all_checkins_for_user_id(user_id)
    user = User.find(user_id)
    checkin_data = user.all_foursq_checkins
    checkin_data.each do |raw_checkin|
      # that true indicates this is our first, initial setup.
      Checkin.create_for_user_from_json(user, raw_checkin.json, true)
    end
  end

  def self.ingest_latest_checkins_for_user_id(user_id)
    user = User.find(user_id)
    if user.checkins.any?
      latest_timestamp = user.checkins.last.timestamp
      # we add 1 to ignore the record we derived this from.
      latest_timestamp = latest_timestamp.to_i + 1

      checkin_data = user.all_foursq_checkins_since(latest_timestamp)
      checkin_data.each do |raw_checkin|
        Checkin.create_for_user_from_json(user, raw_checkin.json)
      end
    else
      self.ingest_all_checkins_for_user_id(user_id)
    end
  end

end
