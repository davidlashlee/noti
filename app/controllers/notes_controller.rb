class NotesController < ApplicationController
	before_action :authenticate_user!

	def index
		@notes = Note.all
	end

	def new
		@note = Note.new
	end

	def create
		@note = Note.new(note_params)
		@note.lists << List.find(params[:id])
		@note.save
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
		params.require(:note).permit(:name)
	end

end