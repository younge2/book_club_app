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


