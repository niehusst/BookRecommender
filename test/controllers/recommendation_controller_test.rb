require 'test_helper'

class RecommendationControllerTest < ActionDispatch::IntegrationTest
    def setup
        @base_title = "BookRecommender"
    end

    test "should get recommendation" do
        get '/recommend/book'
        assert_response :success
        assert_select "title", "Recommendation | #{@base_title}"
    end
end
