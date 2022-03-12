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
    resource :profile, only: :show
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    post '/auth/:provider', to: redirect('/auth/:provider'), as: :auth_request

    namespace :admin do
      root 'home#index'
      resources :categories, only: %i[index new create edit update destroy]
      resources :users, only: %i[index new create edit update destroy]
      resources :bulletins, only: :index do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
