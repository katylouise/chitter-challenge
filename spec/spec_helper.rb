require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'capybara'
require 'capybara/rspec'
require 'database_cleaner'
require 'factory_girl'
require 'orderly'
require 'rspec'
require 'rubygems'
require 'timecop'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app/chitter_app.rb')

require_relative 'factories/user'
require_relative 'helpers/session'

Capybara.app = TheApp::Chitter

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include SessionHelpers
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
