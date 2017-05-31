# frozen_string_literal: true

class BookController < ApplicationController
  def index
    render locals: { note: first_note }
  end

  def review
    render locals: { note: today_viewed }
  end

  def forward
    first_note.read!
    redirect_to root_url
  end

  def reset
    first_note.reset_phase!
    redirect_to root_url
  end

  def touch
    today_viewed.touch!
    redirect_to book_review_url
  end

  private

  def first_note
    current_user.notes.published.stack.first
  end

  def today_viewed
    current_user.notes.today_viewed.stack.first
  end
end
