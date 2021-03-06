require 'sidekiq'

worker_processes 3 # amount of unicorn workers to spin up
timeout 60         # restarts workers that hang for 60 seconds

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
end
    
after_fork do |server, worker|
  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { :size => 5 }
  end

  if defined?(ActiveRecord::Base) 
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5
    ActiveRecord::Base.establish_connection(config)
  end
end
