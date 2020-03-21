class Book < ApplicationRecord
    belongs_to :user
    validates :rating, :inclusion => { :in => 1..5, :message => "Rating not updated; must be between 1 and 5" }
end
