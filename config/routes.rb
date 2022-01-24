# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins, only: %i[index show new create]
    resources :sessions, only: %i[new create destroy]
    resources :users, only: :new
    get '/auth/github/callback', to: 'sessions#create'

    namespace :admin do
      resources :categories, except: :show
      resources :users, except: :show
      resources :bulletins, only: %i[index]
    end
  end
end
