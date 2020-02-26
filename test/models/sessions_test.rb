require 'test_helper'

class SessionsTest < ActiveSupport::TestCase

    test "session create success" do
        flunk "Existing user not recognized"
    end

    test "session create failure" do
        flunk "Not existing user recognized"
        flunk "Bad username accepted"
        flunk "Bad password accepted"
        flunk "User was already logged in"
    end

    test "session destroy success" do
        flunk "Logged in user not logged out"
    end

    test "session destroy failure" do
        flunk "Not logged in user logged out"
    end
end
