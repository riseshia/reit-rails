class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :contents
      t.datetime :last_viewed_at

      t.timestamps
    end
  end
end
