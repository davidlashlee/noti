class NotesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_list

	def set_list
		@list = List.find(params[:list_id])
	end

	def index
		@notes = Note.all
	end

	def new
		@note = @list.notes.new
	end

	def create
		@note = @list.notes.new(note_params)
		@note.save
		redirect_to @list
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:id])

		if @note.update(note_params)
			redirect_to @note
		else
			render 'edit'
		end
	end

	def show
		@note = Note.find(params[:id])
	end

	def destroy
		@notes = Note.find(params[:id])
		@notes.destroy

		redirect_to '/notes/new', :notice => "Your note has been deleted"
	end

	private
	def note_params
		params.require(:note).permit(:body, :done, :list_id)
	end

end