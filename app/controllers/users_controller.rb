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
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      redirect_to user_path 
    else
      render 'edit'
    end
  end

  def upload_photo
    picture_path = params[:user][:profilePic].path
    cloudinary_file = Cloudinary::Uploader.upload(picture_path)
    # @current_user.profilePic = cloudinary_file["public_id"]
    # user = User.find(@current_user.id)
    # @current_user.profilePic = photo_id
    # @current_user.save
    @current_user.update({:profilePic => cloudinary_file["public_id"]})
    # redirect_to user_path
    redirect_to "/users/profile/#{@current_user.id}"
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
