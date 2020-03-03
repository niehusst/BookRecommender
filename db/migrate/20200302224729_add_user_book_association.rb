class AddUserBookAssociation < ActiveRecord::Migration[5.1]
    def self.up
        add_column :books, :user_id, :integer
        add_index 'books', ['user_id'], :name => 'index_book_id' 
    end

    def self.down
        remove_column :books, :user_id
    end
end
