require 'test_helper'

class DevisePagesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @base_title = "BookRecommender"
    end

    test "should get login page" do
        get '/users/sign_in'
        assert_response :success
        assert_select "title", "Log in | #{@base_title}"
    end

    test "should get sign up page" do
        get '/users/sign_up'
        assert_response :success
        assert_select "title", "Sign up | #{@base_title}"
    end

    test "should let user create session" do
        get '/users/sign_in'
        sign_in users(:user1)
        post user_session_url

        follow_redirect!
        assert_response :success, "Didn't redirect to login"
    end

    test "shouldnt let user start session" do
#        assert_raises(StandardError) do 
            get '/users/sign_in'
            sign_in User.new({:email => "fail@example.com", :password => "securepassword", :password_confirmation => "securepassword" }).save(:validate => false)
#User.create!({:email => "guy@gmail.com", :roles => ["admin"], :password => "111111", :password_confirmation => "111111" })

            post user_session_url

            follow_redirect!
            assert_response :failure, "Bad email accepted" 
            #flunk if commands succeed
#flunk "Not existing user recognized"
#        end

        flunk "Bad password accepted"
        flunk "User was already logged in"
    end

    test "session end success" do
        flunk "Logged in user not logged out"
    end

    test "session end failure" do
        flunk "Not logged in user logged out"
    end

end
