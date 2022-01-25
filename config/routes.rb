# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins do
      member do
        patch :moderate
        patch :archive
      end
    end
    resources :sessions, only: %i[new create destroy]
    resources :users, only: :new
    get '/profile', to: 'profiles#index'
    get '/auth/:provider/callback', to: 'sessions#create'

    namespace :admin do
      resources :categories, except: :show
      resources :users, except: :show
      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
