class User < ApplicationRecord
#has_many :books
#(in Book) belongs_to :user
    validates :name, presence: true
end
