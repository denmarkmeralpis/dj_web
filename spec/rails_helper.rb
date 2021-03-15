require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment', __FILE__)

abort('The Rails env is running in production!') if Rails.env.production?

require 'rspec/rails'
require 'factory_bot'
require 'shoulda/matchers'

Dir["#{File.dirname(__FILE__)}/factories/dj_web/**"].each do |f|
  load File.expand_path(f)
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'rails-controller-testing'
Rails::Controller::Testing.install

RSpec.configure do |config|
  config.fixture_path = 'spec/fixtures'
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def http_login
  ENV['DJ_WEB_USERNAME'] = 'user'
  ENV['DJ_WEB_PASSWORD'] = 'pass'

  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('user', 'pass')
end
