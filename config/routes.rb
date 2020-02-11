Rails.application.routes.draw do
  devise_for :users
#  get 'static_pages/home'
  get 'about', to: 'static_pages#about'
  get 'recommend', to: 'static_pages#recommend'
#TODO: make pass books api request query in url??
  get 'recommend/book', to: 'recommendations#book_rec'
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
