# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'users#index'

  # get '/login', to: 'users#login_form'
  # post '/login', to: 'users#login_user'

  # get '/users/:id/discover', to: 'users#discover'
  # resources :users, only: %i[index show create] do
  #   resources :movies, controller: 'user_movies', only: %i[index show] do
  #     resources :view_parties, controller: 'view_parties', only: %i[new create]
  #   end
  # end

  # get '/register', to: 'users#new'

  ################

  root 'users#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  post '/dashboard', to: 'users#create'

  get '/discover', to: 'users#discover'

  resources :movies, controller: 'user_movies', only: %i[index show] do
    resources :view_parties, controller: 'view_parties', only: %i[new create]
  end

  get '/register', to: 'users#new'
end
