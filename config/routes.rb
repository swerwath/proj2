Rails.application.routes.draw do
  devise_for :users
  resources :clubs
  resources :teams
  root to: "home#index"
end
