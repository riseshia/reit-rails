# frozen_string_literal: true

class BookController < ApplicationController
  def index
    render locals: { note: first_note }
  end

  def next
    first_note.read!
    redirect_to root_url
  end

  private

  def first_note
    current_user.notes.pop.first
  end
end
