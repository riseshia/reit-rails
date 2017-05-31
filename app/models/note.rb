# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :contents, presence: true
  validates :phase, presence: true
  validates :last_viewed_at, presence: true
  validates :published_on, presence: true

  scope :stack, -> { order(:phase, :last_viewed_at) }
  scope :published, -> { where("published_on <= ?", Time.zone.now.to_date) }

  FIRST_PHASE = 1
  PHASE_MULTIFLEXER = 3

  def read!
    self.phase = PHASE_MULTIFLEXER * phase
    save!
  end

  def reset_phase!
    self.phase = FIRST_PHASE
    save!
  end

  def phase=(value)
    super
    base_datetime = Time.zone.now
    self.last_viewed_at = base_datetime
    self.published_on = base_datetime + phase.days
  end

  def self.with(user, options = {})
    now = Time.zone.now
    new(
      user: user,
      title: options[:title],
      contents: options[:contents],
      phase: options[:phase] || 1,
      published_on: options[:published_on] || now + 1.day,
      last_viewed_at: options[:last_viewed_at] || now
    )
  end
end
