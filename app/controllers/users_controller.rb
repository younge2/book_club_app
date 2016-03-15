class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.valid?
      flash[:success] = 'Thank you for signing up! Welcome to ReadMe!'
      session[:user_id] = user.id #logs the newly registered user in automatically
      redirect_to root_path
    else
      flash[:warning] = 'Sorry your account was unable to be created. Please
      be sure that your password is at least six characters long, and your confirm password field matches your password.'
      redirect_to signup_path
    end
  end

  def profile
    @user = User.find(params[:id])
    @books = Bookstate.where(user_id: @user.id).to_a
    @allbooks = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      user.update(user_params)
      redirect_to user_path 
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = 'Account successfully deleted. Sorry to see you go!'
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :profilePic, :password, :password_confirmation)
  end
end
