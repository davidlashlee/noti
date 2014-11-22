class ListsController < ApplicationController
	before_action :authenticate_user!
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

		if @list.update(list_params)
			redirect_to @list
		else
			render 'edit'
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