class AdminPagesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @data = User.group(:status).count
    @count_free_users = User.where(status: 0).count
    @count_paid_users = User.where(status: 1).count
    @mainbooks = MainBook.count
    @minibooks = MiniBook.count
  end

  def all_users
    @users = User.all
  end

  def paid_users
    @users = User.where(status: 1)
  end

  def free_users
    @users = User.where(status: 0)
  end
end
