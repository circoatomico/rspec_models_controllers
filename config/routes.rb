Rails.application.routes.draw do
  devise_for :members
  resources :categories
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "categories#index"
end
