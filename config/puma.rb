preload_app!

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 1 }
threads threads_count, threads_count

workers    Integer(ENV['WEB_CONCURRENCY'] || 1)

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'development'

port        ENV.fetch("PORT") { 3000 }

plugin :tmp_restart

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

