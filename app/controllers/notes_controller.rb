# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update destroy]

  # GET /notes
  def index
    @notes = current_user.notes.order(:last_viewed_at).page(params[:page])
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit; end

  # POST /notes
  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      redirect_to new_note_url, notice: "Note was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to notes_url, notice: "Note was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to notes_url, notice: "Note was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def note_params
    params.require(:note).permit(:title, :contents)
  end
end
