ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"
require 'nokogiri'

class ActiveSupport::TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers

    def log_in(user)
        if integration_test?
            #use warden
            login_as(user, :scope => :user)
        else
            #use devise
            sign_in(user)
        end
    end
end

require 'capybara/rails'
require 'capybara/minitest'
#
#class ActionDispatch::IntegrationTest
#  # Make the Capybara DSL available in all integration tests
#  include Capybara::DSL
#  # Make `assert_*` methods behave like Minitest assertions
#  include Capybara::Minitest::Assertions
#
#  # Reset sessions and driver between tests
#  teardown do
#    Capybara.reset_sessions!
#    Capybara.use_default_driver
#  end
#end
