# frozen_string_literal: true

class BookController < ApplicationController
  def index
    render locals: { note: Note.pop.first }
  end

  def next
    Note.pop.first.read!
    redirect_to root_url
  end
end
