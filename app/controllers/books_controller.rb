class BooksController < ApplicationController
before_action :session_url, only: [:edit,:update,:destroy]
  def index
    @book=Book.new
    @books=Book.all
  end
  def create
    @book=Book.new(books_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      render :index
    end
  end


  def show
    @books=Book.find(params[:id])
    @newbook=Book.new
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] ="You have updated book successfully"
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end
  private


  def books_params
    params.require(:book).permit(:title, :body)
  end
  def session_url
    @book=Book.find(params[:id])
    unless current_user==@book.user
      redirect_to books_path
    end
  end
end
