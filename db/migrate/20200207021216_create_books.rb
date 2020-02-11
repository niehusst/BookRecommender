class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :rating
      t.string :img
      t.string :genre

      t.timestamps
    end
  end

  def down
    drop_table :books
  end
end
