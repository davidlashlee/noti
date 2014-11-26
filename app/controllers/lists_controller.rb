class ListsController < ApplicationController
	before_action :authenticate_user!
	before_action :asign

	def asign
		@current_lists = current_user.lists
	end

	def index
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def create
		@list = List.new(list_params)
		@list.users << current_user
		
		if @list.name != nil
			@list.save
			redirect_to lists_path
		end
	end


	def edit
		@list = List.find(params[:id])
	end

	def update
		@list = List.find(params[:id])

		respond_to do |format|
			if @post.update_attributes(params[:post])
				format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    	format.json { head :no_content } # 204 No Content
    		else
    	format.html { render action: "edit" }
    	format.json { render json: @post.errors, status: :unprocessable_entity }
    		end
		end
	end

	def show
		@list = List.find(params[:id])
		@new_note = @list.notes.new
	end

	def destroy
		@lists = List.find(params[:id])
		@lists.destroy

		redirect_to '/lists', :notice => "Your list has been deleted"
	end

	private
	def list_params
	params.require(:list).permit(:name, note_attributes: [:body, :done, :_destory])
	end

end