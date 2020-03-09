require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:book1)
    @user = users(:user1)
    sign_in @user
  end

  teardown do
    sign_out :user
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should not get index" do
    sign_out :user

    get books_url
    assert_redirected_to '/users/sign_in'
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

# test elimenated since books won't be created through this method anyway
#  test "should create book" do
#    assert_difference('Book.count') do
#      post books_url, params: { book: { author: @book.author, genre: @book.genre, img: @book.img, rating: @book.rating, title: @book.title, user_id: @user.id } }
#    end
#
#    assert_redirected_to book_url(Book.last)
#  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    # update only updates the book rating now, so only test updating that field
    patch book_url(@book), params: { book: { rating: @book.rating } }
    assert_redirected_to '/profile'
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
