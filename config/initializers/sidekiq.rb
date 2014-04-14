ENV["REDISTOGO_URL"] ||= "redis://localhost:6379"

# three unicorns = 3 connections
Sidekiq.configure_client do |config|
  config.redis = { :size => 1, :url => ENV['REDISTOGO_URL']}
end
# so one sidekiq can have 7 connections
Sidekiq.configure_server do |config|
  config.redis = { :url => ENV["REDISTOGO_URL"], :size => 7 }
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{ENV['DB_POOL']}"
    ActiveRecord::Base.establish_connection
  end
end

