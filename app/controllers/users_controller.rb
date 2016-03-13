class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:success] = 'Thank you for signing up!'
    session[:user_id] = user.id #logs the newly registered user in automatically
    redirect_to root_path
  end

  def profile
    @user = User.find(params[:id])
  end

  def photo
    picture_path = params[:photo][:picture].path
    cloudinary_file = Cloudinary::Uploader.upload(picture_path)
    # render json: cloudinary_file
    @user = User.find(params[:id])
    @photo = cloudinary_file["public_id"]
    @user.update_attributes(:profilePic => @photo)
    # puts cloudinary_file["public_id"]
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Account successfully deleted. Sorry to see you go!'
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profilePic, :password, :password_confirmation)
  end
end
