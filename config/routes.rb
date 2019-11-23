Rails.application.routes.draw do
  get 'tasks/index'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get '/guest_admin', to: 'users#guest_admin'
  get '/guest_general', to: 'users#guest_general'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    resources :tasks
  end
end
