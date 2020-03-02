require 'test_helper'

class RecommendationControllerTest < ActionDispatch::IntegrationTest
    def setup
        @base_title = "BookRecommender"
        sign_in users(:user1)
    end
    
    def teardown
        sign_out :user
    end

    test "should not get recommend" do
        sign_out :user
        get '/recommend'
        assert_redirected_to '/users/sign_in'
    end
 
    test "should get recommend" do
        get '/recommend'
        assert_response :success
        assert_select "title", "Recommend | #{@base_title}"
    end

    test "should not get recommendation" do
        sign_out :user

        get '/recommend/book'
        assert_redirected_to '/users/sign_in'
    end
 
    test "should get recommendation" do
        get '/recommend/book'
        assert_response :success
        assert_select "title", "Recommendation | #{@base_title}"
    end
 
    test "get random book" do
        get '/recommend/book'
        assert_response :success
        assert_select "#title", /.+/ #assert not empty
    end
 
    test "get popular book" do
        skip "not implemented"
    end
 
    test "get profile matched book" do
        skip "not implemented"
    end
 
    test "get book in genre" do
        skip "not implemented"
    end
end
