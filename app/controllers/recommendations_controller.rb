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
    genre_rec
  end

  # GET /recommend/book/popular
  def popular
    setup
    popular_rec
  end
  
  # GET /recommend/book/match
  def match
    setup
    match_rec
  end
  
  # GET /recommend
  def recommend
  end

  private
  def random_rec
    sub = @subjects.shuffle[0]

    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address
    books = GoogleBooks.search('subject:' + sub, {:count => @quant, :page => 1}, user_ip).to_a
    book = books[(0...books.size).to_a.shuffle.first]
    @title = book.title
    @author = book.authors
    @rating = book.average_rating
    @desc = book.description
    @genre = sub
    @img_link = book.image_link(:zoom => 1)
  end

  def match_rec
    # genres more highly rated by the user are more likely to be selected
    u = current_user
    favs = [u.fantasy, u.scifi, u.mystery, u.romance, u.nonfiction, u.history, u.drama, u.thriller, u.adventure, u.poetry]
    rand = (0...favs.sum).to_a.shuffle.first
    
    i = 0
    while i < favs.size and rand > 0
      rand = rand - favs[i]
      i = i + 1
    end
    if i >= favs.size
      i = i - 1
    end

    sub = @subjects[i]

    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address
    books = GoogleBooks.search('subject:' + sub, {:count => @quant, :page => 1}, user_ip).to_a
    book = books[(0...books.size).to_a.shuffle.first]
    @title = book.title
    @author = book.authors
    @rating = book.average_rating
    @desc = book.description
    @genre = sub
    @img_link = book.image_link(:zoom => 1)
  end

  def genre_rec
    sub = params[:genre]
    if params.include? :page
      page = params[:page].to_i + 1
    else
      page = 1
    end

    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address
    books = GoogleBooks.search('subject:' + sub, {:count => 1, :page => page}, user_ip)
    book = books.first
    @title = book.title
    @author = book.authors
    @rating = book.average_rating
    @desc = book.description
    @genre = sub
    @img_link = book.image_link(:zoom => 1)
  end

  def popular_rec
    # Request made with user's IP address allows access to API from Heroku
    user_ip = request.remote_ip # assuming user is accessing from a valid IP address

    while true
      #randomly get subject and page
      sub = @subjects.shuffle[0]
      page = (0...@quant).to_a.shuffle.first
      books = GoogleBooks.search('subject:' + sub, {:count => @quant, :page => page}, user_ip).to_a
      i = 0
      while i < books.size and (books[i].average_rating.nil? ? 0 : books[i].average_rating ) < 4.5
        i += 1
      end

      if i < books.size
        book = books[i]
        @title = book.title
        @author = book.authors
        @rating = book.average_rating
        @desc = book.description
        @genre = sub
        @img_link = book.image_link(:zoom => 1)
        break
      end
    end
  end

end
