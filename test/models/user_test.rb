require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "create valid user" do
        skip "Valid credentials bad"
    end

    test "create invalid user" do
        skip "Bad email was good"
        flunk "Bad password was good"
        flunk "Empty form was accepted"
        flunk "Identical user emails created"
    end

end
