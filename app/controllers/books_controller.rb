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
      flash[:alert] = "Failed to add book to profile"
      redirect_to '/'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    #only for updating the rating field; nothing else can change
    @book.rating = params[:book][:rating]
    if @book.save
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
