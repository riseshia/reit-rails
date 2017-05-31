class ChangeTypeOfContentsFromNote < ActiveRecord::Migration[5.1]
  def change
    change_column :notes, :contents, :text, null: false
  end
end
