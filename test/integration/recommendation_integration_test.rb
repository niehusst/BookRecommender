require 'test_helper'

class RecommendationIntegrationTest< Capybara::Rails::TestCase
    setup do
        @base_title = '| BookRecommender'
        @user = users(:user1)
        sign_in @user
    end

    teardown do
        sign_out :user
    end
    
    test "love a recommendation button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'

        prev_book_num = @user.books.size
        click_on 'Love it!'
        assert_current_path '/'
        assert_equal prev_book_num+1, @user.books.size, "Number of books belonging to user didn't change"
    end

    test "get next recommendation; nope button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'

        click_on 'Nope'
        # location doesnt change
        assert_current_path '/recommend/book/random'
    end

    test "recommendation method button clicks" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'
        
        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'
        assert_selector 'title', text: 'Random #{@base_title}'

        visit '/'
        click_on 'FOR ME'
        assert_current_path '/recommend/book/match'
        assert_selector 'title', text: 'Match #{@base_title}'

        visit '/'
        click_on 'OTHERS ARE READING'
        assert_current_path '/recommend/book/popular'
        assert_selector 'title', text: 'Popular #{@base_title}'

        visit '/'
        click_on 'Fantasy'
        assert_current_path '/recommend/book/genre/fantasy'
        assert_selector 'title', text: 'Genre #{@base_title}'
    end
end
