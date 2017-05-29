# frozen_string_literal: true

require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "set default value to last_viewed_at before validation" do
    note = Note.create(title: "title", contents: "contents")
    assert note.last_viewed_at <= Time.zone.now
  end

  test "read! touch last_viewed_at" do
    note = Note.create(
      title: "title",
      contents: "contents",
      last_viewed_at: 10.days.ago
    )
    now = Time.zone.now
    note.read!
    assert note.last_viewed_at >= now
  end
end
