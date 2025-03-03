Rails.application.routes.draw do
  devise_for :users
  root 'books#index'

  resources :books, only: %i[index show] do
    member do
      post :borrow
      post :return_book  # ✅ Ensures correct naming
    end
  end

  get 'profile', to: 'users#profile'
  get 'library', to: 'books#library', as: 'library'  # ✅ Moved inside the block
end
