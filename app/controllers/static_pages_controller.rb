class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!  

  # GET '/' when not logged in
  def home
  end

  # GET '/about'
  def about
  end
end
