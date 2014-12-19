class CommentsController < ApplicationController
before_action :find_fpost, only: [:show, :edit, :update, :destroy]
before_action :find_post, only: [:show, :edit, :update, :destroy]
	
	def index
		@comment = Comment.all
	end

	def new
		@comment = Comment.new
	end

	def create
		if params[:fpost_id]
			@p = Fpost.find(params[:fpost_id])
		else
			@p = Post.find(params[:post_id])
		end
		@comment = @p.comments.new(params[:comment].permit(:title, :content, :post, :fpost))
		if @comment.save
			redirect_to :back
		else
			render 'new'
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end


	private
	
	def find_fpost
		@fpost = Fpost.where(:id => params[:fpost_id]).first
	end

	def find_post
		@post = Post.where(:id => params[:post_id]).first
	end
end
