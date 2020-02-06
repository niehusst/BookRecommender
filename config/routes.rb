Rails.application.routes.draw do
#  get 'static_pages/home'
  get 'about', to: 'static_pages#about'
  get 'recommend', to: 'static_pages#recommend'
#TODO: make pass info in url??
  get 'recommend/book', to: 'recommendations#book_rec'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
