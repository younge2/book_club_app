class TopicsController < ApplicationController
	def book_topics
		@top = Topic.new
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])

		if params[:sort] == 'Popularity'
			@topics = Topic.where(book_id: @book.id, club_id: @club.id).order(count: :desc)

		elsif params[:sort] == 'Recent'
			@topics = Topic.where(book_id: @book.id, club_id: @club.id).order(updated_at: :desc)

		else
		@topics = Topic.where(book_id: @book.id, club_id: @club.id)
		end

	end

	def create
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])
		top = @book.topics.create(topic_params)
		top.author = @current_user.id
		top.count = 0
		top.club_id = @club.id
		top.save
		redirect_to some_topics_path

	end



	def topic_params
  		params.require(:topic).permit(:title)
  	end
end

