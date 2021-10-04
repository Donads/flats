Rails.application.routes.draw do
  devise_for :users
  devise_for :property_owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: %i[create edit new show update]
  resources :property_types, only: %i[create edit index new show update]
  resources :property_locations, only: %i[create edit index new show update]
end
