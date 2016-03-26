Rails.application.routes.draw do
  devise_for :users

  resources :clubs
  resources :teams
  resources :announcements
  resources :comments

  root to: "home#index"

  patch 'join/:id', to: 'clubs#join', as: 'join'

end
