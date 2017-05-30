# frozen_string_literal: true

require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "set default value to last_viewed_at before validation" do
    note = Note.create(title: "title", contents: "contents")
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
    note.read!
    assert note.last_viewed_at >= now
    assert_equal 3, note.phase
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
    note.reset_phase!
    assert note.last_viewed_at >= now
    assert_equal 1, note.phase
  end

  test "scope #stack works well" do
    Note.destroy_all
    user = users(:shia)

    last = note_with(user, keyword: "last", phase: 7)
    middle = note_with(user, keyword: "middle", phase: 3)
    second = note_with(user, keyword: "second",
                             phase: 1, last_viewed_at: 1.day.ago)
    first = note_with(user, keyword: "first",
                            phase: 1, last_viewed_at: 2.days.ago)

    assert_equal [first, second, middle, last], Note.stack.to_a
  end

  private

  def note_with(user, keyword:, phase: 1, last_viewed_at: nil)
    user.notes.create(
      title: keyword,
      contents: "#{keyword} contents",
      phase: phase,
      last_viewed_at: last_viewed_at
    )
  end
end
