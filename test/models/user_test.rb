require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "create valid user" do
        flunk "Valid credentials bad"
    end

    test "create invalid user" do
        flunk "Bad email was good"
        flunk "Bad password was good"
        flunk "Empty form was accepted"
        flunk "Identical user emails created"
    end

end
