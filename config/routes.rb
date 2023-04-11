# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  resource :sessions, only: %i[create destroy]

  get '/lang/:lang', to: 'locale#change', as: 'locale'

  resource :users, except: %i[new destroy] do
    get 'sign_up', action: 'new'
    get 'sign_in'
  end

  resources :resumes do
    member { post :like }

    resources :comments, shallow: true, only: %i[create edit update destroy]
  end

  # /api/v1/resumes/:id/sort
  namespace :api do
    namespace :v1 do
      resources :resumes, only: [] do
        member do
          patch :sort
        end
      end
    end
  end

  get '/plan', to: 'plan#payment'
  post '/pay', to: 'plan#pay'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/pricing', to: 'pages#pricing'
end
