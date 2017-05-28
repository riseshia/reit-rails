class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :contents
      t.date :last_viewed_on

      t.timestamps
    end
  end
end
