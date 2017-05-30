class AddPhaseToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :phase, :integer, default: 1, null: false
  end
end
