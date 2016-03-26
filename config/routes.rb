Rails.application.routes.draw do
  devise_for :users

  resources :clubs
  resources :teams
  resources :announcements
  resources :comments

  root to: "home#index"

  patch 'join/:id', to: 'clubs#join', as: 'join'
  patch 'request_to_join/:id', to: 'team_join_requests#create', as: 'request_to_join'
  patch 'retract_request/:id', to: 'team_join_requests#destroy', as: 'retract_request'

end
