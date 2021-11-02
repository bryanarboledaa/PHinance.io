class StaticPagesController < ApplicationController
  def home_page
    @users = User.all
    @free_user = User.where(status: 0)
    @paid_user = User.where(status: 1)
  end

  def pricing; end
end
