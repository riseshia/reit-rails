# frozen_string_literal: true

class Note < ApplicationRecord
  scope :pop, -> { order(:last_viewed_at) }

  before_validation :touch_last_viewed_at

  validates :title, presence: true
  validates :contents, presence: true
  validates :last_viewed_at, presence: true

  def read!
    touch_last_viewed_at
    save!
  end

  private

  def touch_last_viewed_at
    self.last_viewed_at = Time.zone.now
  end
end
