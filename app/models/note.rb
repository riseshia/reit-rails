# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  before_validation :touch_last_viewed_at

  validates :title, presence: true
  validates :contents, presence: true
  validates :last_viewed_at, presence: true

  scope :stack, -> { order(:phase, :last_viewed_at) }

  FIRST_PHASE = 1
  PHASE_MULTIFLEXER = 3

  def read!
    touch_phase! { |obj| obj.phase *= PHASE_MULTIFLEXER }
  end

  def reset_phase!
    touch_phase! { |obj| obj.phase = FIRST_PHASE }
  end

  private

  def touch_phase!
    touch_last_viewed_at(true)
    yield self
    save!
  end

  def touch_last_viewed_at(force = false)
    self.last_viewed_at = nil if force
    self.last_viewed_at ||= Time.zone.now
  end
end
