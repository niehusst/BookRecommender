require 'test_helper'

class BookTest < ActiveSupport::TestCase
    setup do

    end

    test "create valid book" do
        book = Book.create({title: "Catch-22", author: "Joseph Heller", rating: 5, img: "https://bookurl.com", genre: "fiction", user: users(:user1)})
        assert book.valid?, "Valid book was bad"
        assert Book.find_by(title: "Catch-22"), "Couldn't find book in db"
    end

    test "read book" do
        book = books(:book1)
        assert_equal book.title, "booko"
    end

    test "update book" do
        book = books(:book1)
        book.rating = 5
        book.save
        assert book.valid?, "Edited book wasn't valid"
        book.rating = 3.4
        book.save
        assert book.valid?, "decimal rating not accepted"
        assert Book.find_by(title: "booko")
    end

    test "bad update book" do
        book = books(:book1)
        book.rating = -2
        book.save
        assert !book.valid?, "Negative rating was valid"
        book.rating = 0
        book.save
        assert !book.valid?, "0 rating was valid"
        book.rating = 6
        book.save
        assert !book.valid?, "too high rating accepted"
    end

    test "destroy book" do
        book = books(:book1)
        title = book.title
        book.destroy
        assert_nil Book.find_by(title: title)
    end

    test "connection to user model" do
        book = books(:book1)
        assert book.user, "Book was not associated with a user"
        assert_equal users(:user1).id, book.user.id, "Book's user was not user1"
    end
end
