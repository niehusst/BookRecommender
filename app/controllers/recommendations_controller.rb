class RecommendationsController < ApplicationController

  def setup
    @subjects = ['fantasy','science_fiction', 'mystery', 'romance', 'nonfiction', 'history', 'drama', 'thriller', 'adventure', 'poetry']
    @quant = 10
  end

  # GET /recommend/book/random
  def random
    setup
    random_rec
  end
  
  # GET /recommend/book/genre={enum}
  def genre
    setup
    #TODO: call correct helper to set vars for view
    random_rec
  end

  # GET /recommend/book/popular
  def popular
    setup
    #TODO: call correct helper to set vars for view
    random_rec
  end
  
  # GET /recommend/book/match
  def match
    setup
    #TODO: call correct helper to set vars for view
    random_rec
  end
  
  # GET /recommend
  def recommend
  end

  private
  def random_rec
    sub = @subjects.shuffle[0]

    if params.include? :page
      page = params[:page]
    else
      page = 1
    end

    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address
    books = GoogleBooks.search('subject:' + sub, {:count => @quant, :page => page}, user_ip)
    book = books.to_a[(0...@quant).to_a.shuffle.first]
    @title = book.title
    @author = book.authors
    @rating = book.average_rating
    @desc = book.description
    @genre = sub
    @img_link = book.image_link(:zoom => 1)
  end
end
