class NotesController < ApplicationController
	def index
		@notes = Note.all
	end

	def new
		@note = Note.new
	end

	def create
		@note = Note.new(note_params)
		if @note.body.inclues? "lookup"
		

		@note.save
		redirect_to @note
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