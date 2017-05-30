class AddPublishedOnToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :published_on, :date

    Note.find_each do |note|
      note.published_on = Time.zone.now
      note.save!
    end
  end
end
