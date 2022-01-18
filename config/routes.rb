# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'bulletins#index'
  resources :bulletins
  resources :sessions, only: %i[new create]
  post '/auth/github/callback', to: 'sessions#create'
end
