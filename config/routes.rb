Rails.application.routes.draw do
  devise_for :users

  resources :clubs
  resources :teams
  resources :announcements
  resources :comments
  resources :equipment

  root to: "home#index"

  get 'teams/new', to: 'teams#new', as: 'create_team'
  get 'landing', to: 'home#landing', as: 'landing'

  patch 'equipment_checkout/:id', to: 'equipment#checkout', as: 'equipment_checkout'
  patch 'equipment_return/:id', to: 'equipment#return', as: 'equipment_return'

  patch 'destroy_announcement/:id', to: 'announcements#destroy', as: 'destroy_announcement'
  patch 'destroy_comment/:id', to: 'comments#destroy', as: 'destroy_comment'

  patch 'join/:id', to: 'clubs#join', as: 'join'
  patch 'join_team/:id', to: 'teams#join', as: 'join_team'
  patch 'approve/:id', to: 'team_join_requests#approve', as: 'approve'
  patch 'destroy/:id', to: 'team_join_requests#destroy', as: 'destroy'

  patch 'remove_user/:id', to: 'teams#remove_user', as: 'remove_user'
  patch 'promote_user/:id', to: 'teams#promote_user', as: 'promote_user'

  patch 'add_user_to_team/:id', to: 'teams#add_user_to_team', as: 'add_user_to_team'

  patch 'request_to_join/:id', to: 'team_join_requests#create', as: 'request_to_join'
  patch 'retract_request/:id', to: 'team_join_requests#destroy', as: 'retract_request'

end
