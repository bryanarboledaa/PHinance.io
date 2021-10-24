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

  private

  def mini_book_params
    params.require(:mini_book).permit(:user_id, :minibook_name, :minibook_price)
  end
end