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

    test "recommendation method paths" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'
        
        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'
        assert_title "Random #{@base_title}"

        visit '/'
        click_on 'FOR ME'
        assert_current_path '/recommend/book/match'
        assert_title "Match #{@base_title}"

        visit '/'
        click_on 'OTHERS ARE READING'
        assert_current_path '/recommend/book/popular'
        assert_title "Popular #{@base_title}"

        visit '/'
        click_on 'Fantasy'
        assert_current_path '/recommend/book/genre/fantasy'
        assert_title "Genre #{@base_title}"
    end

# RANDOM REC TESTS
    test "love a random recommendation button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'

        prev_book_num = @user.books.size
        click_on 'Save Recommendation'
        assert_current_path '/'
        assert_equal prev_book_num+1, @user.books.size, "Number of books belonging to user didn't change"
    end

    test "get next random recommendation" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'

        click_on 'Next Recommendation'
        # location doesnt change
        assert_current_path '/recommend/book/random'
    end

    test "create and rate random book button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'SURPRISE ME'
        assert_current_path '/recommend/book/random'
        
        # save book title for search later
        parsed_data = Nokogiri::HTML.parse(page.html)
        book_title = parsed_data.at_css('[id="title"]').text.slice(1..-2)

        click_on 'Already read it'
        # assert page redirect to books#edit
        assert_title "Rate Book #{@base_title}"
        # fill in rating update
        page.fill_in 'Rating', with: 3
        click_on 'Update Book'
        assert_current_path '/profile'

        # assert book was added with correct rating
        assert page.has_text?(book_title)
        assert page.has_text?('Your rating: 3', minimum: 1)
    end


# POPULAR REC TESTS
    test "love a popular recommendation button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'OTHERS ARE READING'
        assert_current_path '/recommend/book/popular'

        prev_book_num = @user.books.size
        click_on 'Save Recommendation'
        assert_current_path '/'
        assert_equal prev_book_num+1, @user.books.size, "Number of books belonging to user didn't change"
    end

    test "get next popular recommendation" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'OTHERS ARE READING'
        assert_current_path '/recommend/book/popular'

        click_on 'Next Recommendation'
        # location doesnt change
        assert_current_path '/recommend/book/popular'
    end

    test "create and rate popular book button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'OTHERS ARE READING'
        assert_current_path '/recommend/book/popular'
        
        # save book title for search later
        parsed_data = Nokogiri::HTML.parse(page.html)
        book_title = parsed_data.at_css('[id="title"]').text.slice(1..-2)

        click_on 'Already read it'
        # assert page redirect to books#edit
        assert_title "Rate Book #{@base_title}"
        # fill in rating update
        page.fill_in 'Rating', with: 3
        click_on 'Update Book'
        assert_current_path '/profile'

        # assert book was added with correct rating
        assert page.has_text?(book_title)
        assert page.has_text?('Your rating: 3', minimum: 1)
    end



# MATCH REC TESTS
    test "love a match recommendation button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'FOR ME'
        assert_current_path '/recommend/book/match'

        prev_book_num = @user.books.size
        click_on 'Save Recommendation'
        assert_current_path '/'
        assert_equal prev_book_num+1, @user.books.size, "Number of books belonging to user didn't change"
    end

    test "get next match recommendation" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'FOR ME'
        assert_current_path '/recommend/book/match'

        click_on 'Next Recommendation'
        # location doesnt change
        assert_current_path '/recommend/book/match'
    end

    test "create and rate match book button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'FOR ME'
        assert_current_path '/recommend/book/match'
        
        # save book title for search later
        parsed_data = Nokogiri::HTML.parse(page.html)
        book_title = parsed_data.at_css('[id="title"]').text.slice(1..-2)

        click_on 'Already read it'
        # assert page redirect to books#edit
        assert_title "Rate Book #{@base_title}"
        # fill in rating update
        page.fill_in 'Rating', with: 3
        click_on 'Update Book'
        assert_current_path '/profile'

        # assert book was added with correct rating
        assert page.has_text?(book_title)
        assert page.has_text?('Your rating: 3', minimum: 1)
    end


# GENRE REC TESTS
    test "love a genre recommendation button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'Fantasy'
        assert_current_path '/recommend/book/genre/fantasy'

        prev_book_num = @user.books.size
        click_on 'Save Recommendation'
        assert_current_path '/'
        assert_equal prev_book_num+1, @user.books.size, "Number of books belonging to user didn't change"
    end

    test "get next genre recommendation" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'Fantasy'
        assert_current_path '/recommend/book/genre/fantasy'

        click_on 'Next Recommendation'
        # page increment
        assert_current_path '/recommend/book/genre/fantasy/1'
        click_on 'Next Recommendation'
        assert_current_path '/recommend/book/genre/fantasy/2'
    end

    test "create and rate genre book button" do
        visit '/'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'Fantasy'
        assert_current_path '/recommend/book/genre/fantasy'
        
        # save book title for search later
        parsed_data = Nokogiri::HTML.parse(page.html)
        book_title = parsed_data.at_css('[id="title"]').text.slice(1..-2)

        click_on 'Already read it'
        # assert page redirect to books#edit
        assert_title "Rate Book #{@base_title}"
        # fill in rating update
        page.fill_in 'Rating', with: 3
        click_on 'Update Book'
        assert_current_path '/profile'

        # assert book was added with correct rating
        assert page.has_text?(book_title)
        assert page.has_text?('Your rating: 3', minimum: 1)
    end
end
