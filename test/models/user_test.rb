require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "create valid user" do
        user = User.new({email: 'test1@example.com', password: 'password', password_confirmation: 'password'})
        user.save
        assert user.valid?, "Valid credentials bad"
    end

    test "create invalid user" do
        bad_email_user = User.new({email: 'not-an-email', password: 'password', password_confirmation: 'password'})
        bad_email_user.save
        refute bad_email_user.valid?, "Bad email was good"

        bad_pass_user = User.new({email: 'test2@example.com', password: 'word', password_confirmation: 'word'})
        bad_pass_user.save
        refute bad_pass_user.valid?, "Bad password was good"
        
        mismatch_pass_user = User.new({email: 'test3@example.com', password: 'password', password_confirmation: 'passwords'})
        mismatch_pass_user.save
        refute mismatch_pass_user.valid?, "Mismatching passwords were accepted"

        empty_email_user = User.new({email: '', password: 'password', password_confirmation: 'password'})
        empty_email_user.save
        refute empty_email_user.valid?, "Empty email was accepted"
    end

    test "add books to user" do
        user = users(:user1)
        assert_equal 1, user.books.count, "user1 didn't have 1 initial book"
#user.books.push 
        user.books.create({title: 'Catch-22', author: 'Joseph Heller'})
        assert Book.find_by(title: 'Catch-22')
        assert_equal 2, user.books.count
    end

    test "update book rating" do
        user = users(:user1)
        rate = 5
       
        assert user.books.first, "user1 didn't have 1 initial book"
        book = user.books.first
        book.rating = rate
        book.save
        assert book.valid?, "Valid rating edit invalidates book"
        assert user.valid?, "Valid rating edit invalidates user"
        
        #fetch new copy from db?
        user = users(:user1)
        assert_equal rate, user.books.first.rating, "Reloaded user didn't have updated rating"
    end
end
