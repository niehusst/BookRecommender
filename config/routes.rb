Rails.application.routes.draw do
  devise_for :users do
    get 'profile/edit' => 'devise/registration#edit', :as => :edit_user_profile
  end
#devise_for :users
  resources :books
  
  get '/about', to: 'static_pages#about'
  get '/recommend', to: 'recommendations#recommend'

  get 'recommend/book/random', to: 'recommendations#random'
  get 'recommend/book/popular', to: 'recommendations#popular'
  get 'recommend/book/match', to: 'recommendations#match'
  get 'recommend/book/genre/:genre(/:page)', to: 'recommendations#genre'
  post 'recommend/book', to: 'recommendations#create_and_rate', as: :book_create_and_rate

  get 'profile/', to: 'profile#profile'

# change which page is home for loggedin and unloggedin users
  unauthenticated :user do
    root 'static_pages#home'
  end

  authenticated :user do
    root to: 'recommendations#recommend'
  end
end
