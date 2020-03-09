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

        get '/recommend/book/random'
        assert_redirected_to '/users/sign_in'
    end
 
    test "should get recommendation" do
        get '/recommend/book/random'
        assert_response :success
        assert_select "title", "Random | #{@base_title}"
    end
 
    test "get random book" do
        get '/recommend/book/random'
        assert_response :success
        assert_select "#title", /.+/ #assert not empty
        assert_select 'title', "Random | #{@base_title}"
    end
 
    test "get popular book" do
        get '/recommend/book/popular'
        assert_response :success
        assert_select "#title", /.+/ #assert not empty
        assert_select 'title', "Popular | #{@base_title}"
    end
 
    test "get profile matched book" do
        get '/recommend/book/match'
        assert_response :success
        assert_select "#title", /.+/ #assert not empty
        assert_select 'title', "Match | #{@base_title}"
    end
 
    test "get book in genre" do
        #TODO: test all possible genre entries
        get '/recommend/book/genre/poetry'
        assert_response :success
        assert_select "#title", /.+/ #assert not empty
        assert_select 'title', "Genre | #{@base_title}"
    end
end
