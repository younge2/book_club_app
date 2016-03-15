class ClubsController < ApplicationController
	before_action :is_authenticated?, except: [:index]

  def index
  	@clubs = Club.all
    @club = Club.new

  end

  def create
  	club = @current_user.clubs.create(club_params) do |o|
  	o.owner = @current_user.id
  	end
		redirect_to clubs_path 
  end


  def new
  	@club = Club.new
  end

  def show
  	@club = Club.find(params[:id])
    @user = User.find_by_id(@current_user.id)
    @club.users.find_by_id(@current_user)

  end
  def update
    @club = Club.find(params[:id])
    @join = Club.find_by_id(@club).users << User.find_by_id(current_user.id)
    redirect_to club_path
      #use put method on button

  end
  def addbook
    @club = Club.find(params[:id])
    @bookadd = Club.find_by_id(@club).books << Book.find_by_id(params[:id])
    redirect_to club_path
      #use put method on button

  end


  def quit_club  

    @user = User.find_by_id(@current_user.id)
    @club = Club.find(params[:id])
    @quit_club = @club.users.delete(@user)
    
    redirect_to club_path
    
  end

  def edit
  	@club = Club.find(params[:id])
  end

  def destroy
    Club.find(params[:id]).destroy
    redirect_to clubs_path
  end

  private
		def club_params
		  params.require(:club).permit(:name, :blurb, :owner)
		end

    def user_params
      params.require(:user).permit(:id)
    end

end


