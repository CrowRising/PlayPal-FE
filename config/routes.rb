# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'

  get '/playgrounds', to: 'playgrounds#index'
  get '/playgrounds/:id', to: 'playgrounds#show'
  post '/add_to_favorites', to: 'playgrounds/favorites#create'
  get '/review', to: 'reviews#new', as: 'new_review'
  post '/add_review', to: 'reviews#create'
end
