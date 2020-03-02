class RecommendationsController < ApplicationController
  # GET /recommendation/book/
  def book_rec
    #TODO: call correct helper to set vars for view
    random
  end

  # GET /recommend
  def recommend
  end

  private
  def random
    subjects = ['fantasy','science_fiction', 'mystery', 'romance', 'nonfiction', 'history', 'drama', 'thriller', 'adventure', 'poetry']
    sub = subjects.shuffle[0]
    quant = 10
    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address
    books = GoogleBooks.search('subject:' + sub, {:count => quant, :page => 1}, user_ip)
    book = books.to_a[(0...quant).to_a.shuffle.first]
    @title = book.title
    @author = book.authors
    @rating = book.average_rating
    @desc = book.description
    @img_link = book.image_link(:zoom => 1)
  end
end
