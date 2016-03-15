class CommentsController < ApplicationController
	def topic_comments
		@post = Comment.new
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])
		@topic = Topic.find(params[:topic_id])
		@comments = Comment.where(topic_id: @topic.id)
		@arr = Hash.new
		@comments.each do |comment|
			@arr[comment] = User.find_by_id(comment.author)
		end

	end

	def create
		@topic = Topic.find(params[:topic_id])
		com = @topic.comments.create(comment_params)
		com.author = @current_user.id
		com.save
		redirect_to all_comments_path

	end

	def edit
		@club = Club.find(params[:club_id])
		@book = Book.find(params[:book_id])
		@topic = Topic.find(params[:topic_id])
		@comment = Comment.find_by_id(params[:comment_id])
	end

	def change
		@comment = Comment.find_by_id(params[:comment_id])
		@comment.update(comment_params)
		redirect_to all_comments_path
	end

	def delete
		@comment = Comment.find_by_id(params[:comment_id])
		@comment.destroy
		redirect_to all_comments_path
	end



	def comment_params
  	params.require(:comment).permit(:content)
  end

end
