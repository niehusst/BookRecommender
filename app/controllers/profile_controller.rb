class ProfileController < ApplicationController
    def profile
        @books = current_user.books
    end
end
