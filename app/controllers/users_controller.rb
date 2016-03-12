class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:success] = 'User created!'
    session[:user_id] = user.id #logs the new user in automatically
    redirect_to root_path
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
