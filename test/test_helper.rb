ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

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
