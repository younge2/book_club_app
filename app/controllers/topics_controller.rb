class TopicsController < ApplicationController
	def book_topics
		@top = Topic.new
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])
		@topics = Topic.where(book_id: @book.id)

	end

	def create
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])
		top = @book.topics.create(topic_params)
		top.author = @current_user.id
		top.save
		redirect_to some_topics_path

	end


	def topic_params
  		params.require(:topic).permit(:title)
  	end
end
