class FpostsController < ApplicationController

	#before_action :find_fpost, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@fposts = Fpost.all.order('created_at DESC')
	end

	def show
		@fpost = Fpost.find(params[:id])
		@comment = Comment.new
	end

	def new
		@fpost = current_user.fposts.build
	end

	def create
		@fpost = current_user.fposts.build(fpost_params)

		if @fpost.save
			redirect_to @fpost
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @fpost.update(fpost_params)
			redirect_to @fpost
		else 
			render 'edit'
		end
	end

	def destroy
		@fpost.destroy
		redirect_to root_path
	end

	private

	#def find_fpost
		#@fpost = Fpost.find(params[:id])
	#end

	def fpost_params
		params.require(:fpost).permit(:title, :content, :user_id)
	end
end
