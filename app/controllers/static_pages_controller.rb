class StaticPagesController < ApplicationController
  def home_page
    @users = User.all
    @free_user = @users.where(status: 0)
    @paid_user = @users.where(status: 1)
  end

  def pricing; end
end
