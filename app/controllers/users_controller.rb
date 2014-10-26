class UsersController < ApplicationController
  respond_to :html
  filter_resource_access

  def index
    @users = User.all.page(params[:page])

    respond_with(@users)
  end

  def show
    @collections = @user.collections.page(params[:page])

    respond_with(@user)
  end
end