Rails.application.routes.draw do
  devise_for :users
  resources :books
  
  get 'about', to: 'static_pages#about'
  get 'recommend', to: 'static_pages#recommend'
#TODO: make pass books api request query in url??
  get 'recommend/book', to: 'recommendations#book_rec'

  
# change which page is home for loggedin and unloggedin users
  unauthenticated :user do
    root 'static_pages#home'
  end

  authenticated :user do
    root to: 'static_pages#recommend'
  end
end
