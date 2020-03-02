require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "create valid user" do
        user = User.new({email: 'test1@example.com', password: 'password', password_confirmation: 'password'})
        user.save
        assert user.valid?, "Valid credentials bad"
    end

    test "create invalid user" do
        bad_email_user = User.new({email: 'not-an-email', password: 'password', password_confirmation: 'password'})
        bad_email_user.save
        refute bad_email_user.valid?, "Bad email was good"

        bad_pass_user = User.new({email: 'test2@example.com', password: 'word', password_confirmation: 'word'})
        bad_pass_user.save
        refute bad_pass_user.valid?, "Bad password was good"
        
        mismatch_pass_user = User.new({email: 'test3@example.com', password: 'password', password_confirmation: 'passwords'})
        mismatch_pass_user.save
        refute mismatch_pass_user.valid?, "Mismatching passwords were accepted"

        empty_email_user = User.new({email: '', password: 'password', password_confirmation: 'password'})
        empty_email_user.save
        refute empty_email_user.valid?, "Empty email was accepted"
    end

    test "add books to user" do
        skip "not implemntned"
    end
end
