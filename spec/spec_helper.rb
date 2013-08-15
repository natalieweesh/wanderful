ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def sign_up(username)
  visit "/users/sign_up"
  fill_in "user_username", with: username
  fill_in "user_email", with: "#{username}@gmail.com"
  fill_in "user_password", with: 'password'
  fill_in "user_password_confirmation", with: 'password'
  click_button 'sign up'
end

def sign_up_as_hello_world
  sign_up("helloworld")
end

def sign_in(username)
  visit "/users/sign_in"
  fill_in "user_login", with: username
  fill_in "user_password", with: 'password'
  click_button 'sign in'
end

