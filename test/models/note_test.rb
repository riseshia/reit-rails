# frozen_string_literal: true

require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "set default value to last_viewed_at before validation" do
    note = Note.create(title: "title", contents: "contents", phase: 1)
    assert note.last_viewed_at <= Time.zone.now
  end

  test "read!" do
    note = Note.create(
      title: "title",
      contents: "contents",
      last_viewed_at: 10.days.ago,
      phase: 1,
      user: users(:shia)
    )
    now = Time.zone.now
    expected_published_on = (now + 3.days).to_date
    note.read!
    assert note.last_viewed_at >= now
    assert_equal 3, note.phase
    assert_equal expected_published_on, note.published_on
  end

  test "reset_phase!" do
    note = Note.create(
      title: "title",
      contents: "contents",
      last_viewed_at: 10.days.ago,
      phase: 9,
      user: users(:shia)
    )
    now = Time.zone.now
    expected_published_on = (now + 1.day).to_date
    note.reset_phase!
    assert note.last_viewed_at >= now
    assert_equal 1, note.phase
    assert_equal expected_published_on, note.published_on
  end

  test "scope #stack works well" do
    Note.destroy_all
    user = users(:shia)

    note_with(user, keyword: "last", phase: 7, published_on: 2.days.from_now)
    last = note_with(user, keyword: "last", phase: 7,
                           last_viewed_at: 8.days.ago, published_on: 1.day.ago)
    middle = note_with(user, keyword: "middle", phase: 3,
                             last_viewed_at: 4.days.ago, published_on: 1.day.ago)
    second = note_with(user, keyword: "second",
                             phase: 1, last_viewed_at: 1.day.ago)
    first = note_with(user, keyword: "first",
                            phase: 1, last_viewed_at: 2.days.ago)

    assert_equal [first, second, middle, last], Note.stack.to_a
  end

  private

  def note_with(user,
                keyword:, phase: 1,
                last_viewed_at: nil, published_on: 1.day.ago)
    user.notes.create(
      title: keyword,
      contents: "#{keyword} contents",
      phase: phase,
      last_viewed_at: last_viewed_at,
      published_on: published_on
    )
  end
end
