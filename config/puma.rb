preload_app!

workers    Integer(ENV['WEB_CONCURRENCY'] || 2)
threads 0, Integer(ENV['MAX_THREADS']     || 16)

rackup      DefaultRackup
bind        'tcp://0.0.0.0:8000'
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
