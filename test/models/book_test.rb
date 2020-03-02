require 'test_helper'

class BookTest < ActiveSupport::TestCase
    setup do

    end

    test "create valid book" do
        book = Book.create({title: "Catch-22", author: "Joseph Heller", rating: 5, img: "https://bookurl.com", genre: "fiction"})
        assert book.valid?, "Valid book was bad"
        assert Book.find_by(title: "Catch-22"), "Couldn't find book in db"
    end

    test "read book" do
        book = books(:book1)
        assert_equal book.title, "booko"
    end

    test "update book" do
        book = books(:book1)
        book.title = "Turtles all the way down"
        book.author = "Hank Green"
        book.save
        assert book.valid?, "Edited book wasn't valid"
        assert Book.find_by(author: "Hank Green")
    end

    test "destroy book" do
        book = books(:book1)
        title = book.title
        book.destroy
        assert_nil Book.find_by(title: title)
    end
end
