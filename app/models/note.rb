# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  before_validation :touch_last_viewed_at

  validates :title, presence: true
  validates :contents, presence: true
  validates :last_viewed_at, presence: true

  scope :pop, -> { order(:last_viewed_at) }

  def read!
    touch_last_viewed_at
    save!
  end

  private

  def touch_last_viewed_at
    self.last_viewed_at = Time.zone.now
  end
end
