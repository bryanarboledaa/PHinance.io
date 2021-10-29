class MiniBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @mini_books = MiniBook.all
  end

  def new
    @mini_book = current_user.mini_books.build
  end

  def create
    @mini_book = current_user.mini_books.build(mini_book_params)
    if @mini_book.save
      redirect_to minibooks_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @mini_book = MiniBook.find(params[:id])
  end

  def update
    @mini_book = MiniBook.find(params[:id])
    if @mini_book.update(mini_book_params)
      flash[:notice] = 'Sucessfully updated MiniBook'
      redirect_to minibooks_path
    else
      render :edit
    end
  end

  def destroy
    @mini_book = MiniBook.find(params[:id])
    if @mini_book.destroy
      flash[:notice] = 'Sucessfully deleted Mini Book'
      redirect_to minibooks_path
    else
      render :minibooks_path
    end
  end

  def correct_user
    @mini_book = current_user.mini_books.find_by(id: params[:id])
    redirect_to minibooks_path, notice: 'Not Authorized to access this page' if @mini_book.nil?
  end

  private

  def mini_book_params
    params.require(:mini_book).permit(:user_id, :minibook_name, :minibook_price)
  end
end
