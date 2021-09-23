Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: %i[create new show]
  resources :property_types, only: %i[create index new show]
  resources :property_locations, only: %i[create index new show]
end
