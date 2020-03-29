class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
      
    if @book.save
      flash[:notice] = "Book successfully added to profile"
      redirect_to '/'
    else
      if @book.errors[:title].include? 'has already been taken'
        flash[:notice] = "Book was already in profile"
      else
        flash[:alert] = "Failed to add book to profile"
      end
      redirect_to '/'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    #only for updating the rating field; nothing else can change
    prev_rating = @book.rating
    @book.rating = params[:book][:rating]

    if @book.save
      # update user's fav genres score
      case @book.genre
      when "fantasy"
        #undo prev rating, if there was one
        unless prev_rating.nil?
          current_user.fantasy -= (prev_rating - 3)
        end
        #add score for new rating. 
        #The (rating - 3) allows bad ratings to negatively affect fav genre score
        current_user.fantasy = [0, current_user.fantasy + (@book.rating - 3)].max
      when "science_fiction"
        unless prev_rating.nil?
          current_user.scifi -= (prev_rating - 3)
        end

        current_user.scifi = [0, current_user.scifi + (@book.rating - 3)].max
      when "mystery"
        unless prev_rating.nil?
          current_user.mystery -= (prev_rating - 3)
        end

        current_user.mystery = [0, current_user.mystery + (@book.rating - 3)].max
      when "romance"
        unless prev_rating.nil?
          current_user.romance -= (prev_rating - 3)
        end

        current_user.romance = [0, current_user.romance + (@book.rating - 3)].max
      when "nonfiction"
        unless prev_rating.nil?
          current_user.nonfiction -= (prev_rating - 3)
        end

        current_user.nonfiction = [0, current_user.nonfiction + (@book.rating - 3)].max
      when "history"
        unless prev_rating.nil?
          current_user.history -= (prev_rating - 3)
        end

        current_user.history = [0, current_user.history + (@book.rating - 3)].max
      when "drama"
        unless prev_rating.nil?
          current_user.drama -= (prev_rating - 3)
        end

        current_user.drama = [0, current_user.drama + (@book.rating - 3)].max
      when "thriller"
        unless prev_rating.nil?
          current_user.thriller -= (prev_rating - 3)
        end

        current_user.thriller = [0, current_user.thriller + (@book.rating - 3)].max
      when "adventure"
        unless prev_rating.nil?
          current_user.adventure -= (prev_rating - 3)
        end

        current_user.adventure = [0, current_user.adventure + (@book.rating - 3)].max
      when "poetry"
        unless prev_rating.nil?
          current_user.poetry -= (prev_rating - 3)
        end

        current_user.poetry = [0, current_user.poetry + (@book.rating - 3)].max
      end
      current_user.save()

      flash[:notice] = "Book rating sucessfully updated"
      redirect_to '/profile'
    else
      flash[:alert] = @book.errors[:rating].first
      redirect_to edit_book_path(Book.find(params[:id]))
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
#      params.permit(:title, :author, :rating, :img, :genre, :description, :id, :authenticity_token)
      book_stuff = { title: params[:title], 
                     author: params[:author], 
                     img: params[:img], 
                     genre: params[:genre], 
                     description: params[:description], 
                     user: current_user }
      
      return book_stuff
    end
end
