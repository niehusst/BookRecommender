class AddFavsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fantasy, :integer, :null => false, :default => 6
    add_column :users, :scifi, :integer, :null => false, :default => 6
    add_column :users, :mystery, :integer, :null => false, :default => 6
    add_column :users, :romance, :integer, :null => false, :default => 6
    add_column :users, :nonfiction, :integer, :null => false, :default => 6
    add_column :users, :history, :integer, :null => false, :default => 6
    add_column :users, :drama, :integer, :null => false, :default => 6
    add_column :users, :thriller, :integer, :null => false, :default => 6
    add_column :users, :adventure, :integer, :null => false, :default => 6
    add_column :users, :poetry, :integer, :null => false, :default => 6
  end
end
