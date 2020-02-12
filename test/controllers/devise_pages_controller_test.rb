require 'test_helper'

class DevisePagesControllerTest < ActionDispatch::IntegrationTest
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
end
