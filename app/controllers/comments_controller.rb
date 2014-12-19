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
		# @post = Post.find(params[:post_id])
		#@fpost = current_user.fposts.build
		#@fpost = Fpost.find(params[:fpost_id])
		# @comment = @post.comments.create(params[:comment].permit(:name, :body))
		@comment = Comment.new(params[:comment].permit(:title, :content, :post, :fpost))
		@comment.fpost = @fpost
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
