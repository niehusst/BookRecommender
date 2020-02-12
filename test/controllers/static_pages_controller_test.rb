require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @base_title = "BookRecommender"
    end

    test "should get home" do
        get root_path
        assert_response :success
        assert_select "title", "Home | #{@base_title}"
    end

    test "should get about" do
        get about_path
        assert_response :success
        assert_select "title", "About | #{@base_title}"
    end

    test "should get recommend" do
        get recommend_path
        assert_response :success
        assert_select "title", "Recommend | #{@base_title}"
    end
end
