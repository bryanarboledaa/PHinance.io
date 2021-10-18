class MiniBooksController < ApplicationController
  def index
    @mini_books = MiniBook.all
  end

  def new
    @mini_book = MiniBook.new
  end

  def create
    @mini_book = MiniBook.new(mini_book_params)
    if @mini_book.save
      redirect_to minibooks_path
    else
      render :new
    end
  end

  private

  def mini_book_params
    params.require(:mini_book).permit(:user_id, :minibook_name, :minibook_price)
  end
end
