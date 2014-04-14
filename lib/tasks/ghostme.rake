namespace :ghostme do
  desc "Ingest latest checkins for all users"  
  task :ingest_all => :environment do
    users = User.all
    users.each do |user|
      CheckinIngester.delay.ingest_latest_checkins_for_user_id(user.id)
      puts "Queuing ingest of checkins for #{user.name}"
    end
  end

  desc "Re-post any checkins (run once a minute under cron)"
  task :repost_checkins => :environment do
    Checkin.order(:timestamp).where(:reposted => false, :scheduled => false).each do |checkin|
      CheckinCreator.schedule_at_mirror_for_checkin_id(checkin.id)
      print "."
    end
  puts
  end

  desc "Update photo URLs for all users"
  task :update_photo_urls => :environment do
    users = User.all
    users.each do |user|
      next unless user.access_token
      f = GhostClient.foursquare_client(user.access_token)

      fs_user = f.user('self')
      user.photo_prefix = fs_user.photo.prefix
      user.photo_suffix = fs_user.photo.suffix
      user.save
      puts "Updated #{user.name}"
    end
  end
end
