ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)

require "rspec/rails"
require "database_cleaner"

require "capybara/rspec"
require "capybara/rails"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.before :suite do
    DatabaseCleaner.strategy = :deletion, { except: "public.schema_migrations" }
    DatabaseCleaner.clean
  end

  config.before :each do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  # config.order = :random
  # Kernel.srand config.seed
  #
end
