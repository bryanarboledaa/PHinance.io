class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[user_dashboard]
  def user_dashboard
    @main_books = MainBook.all
    @main_book_graph = MainBook.group_by_day(:date_mainb).count
    @mainbook_debit_graph = MainBook.group(:debit_mainb).count
  end

  def correct_user
    @main_book = current_user.main_books.find_by(id: params[:id])
  end
end
