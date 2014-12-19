class PostsController < ApplicationController

	def index
		@posts = Post.all.order('created_at DESC')
		binding.pry
	end

	def new
		@post = Post.new
		@comment = Comment.new
	end

	def show
		@post = Post.find(params[:id]) 
		@fpost = @post
		@comment = Comment.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body, :user_id))
			redirect_to @post
		else
			render 'edit'
		end
	end
    
    def add_comment
    	#Comment will be initialized with a valid post id, so relationship with post
    	#will be automatically established. This works because comment_params has the post
    	#id that it extracts from the incoming form submission
       @comment = Comment.new(comment_params)
       @comment.save
       redirect_to 
    end
     
	def home
		
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :body, :user_id)
	end

	def comment_params
		params.require(:comment).permit(:title, :body, :post_id)
	end	
end
