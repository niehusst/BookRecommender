class Book < ApplicationRecord
    belongs_to :user
    validates :rating, :inclusion => { :in => [nil,1,2,3,4,5], :message => "Rating not updated; must be between 1 and 5" }
end
