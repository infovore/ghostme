class User < ActiveRecord::Base
  require 'addressable/uri'
  require 'open-uri'

  def name
    "#{firstname} #{lastname}"
  end

  def all_foursq_checkins(options={})
    # TODO: you can replace this with Quimby.
    count = 100
    offset = 0
    items = []
    while count == 100
      final_query = {:oauth_token => access_token, :limit => count.to_s, :offset => offset.to_s}.merge(options)
      raw_json = RestClient.get 'https://api.foursquare.com/v2/users/self/checkins', {:params => final_query}

      data = JSON.parse(raw_json)
      actual_data = data["response"]["checkins"]["items"]
      items += actual_data
      count = actual_data.count
      offset = offset + count
    end
    items
  end

  def all_foursq_checkins_since(timestamp)
    all_foursq_checkins("afterTimestamp" => timestamp.to_s)
  end

  def next_checkin_after(t)
    checkins.where("timestamp >= #{t.to_i}").first
  end
end
