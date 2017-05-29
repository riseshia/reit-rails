class AddUserIdToNotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :user, index: true
  end
end
