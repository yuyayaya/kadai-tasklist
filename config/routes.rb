Rails.application.routes.draw do
  root to:"tasks#index"
  
  get 'sessions/new'
  post 'sessions/create', to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  get "signup", to: "users#new"
  
  resources :tasks
  
  resources :users, only:[:new, :create]
end
