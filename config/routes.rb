Rails.application.routes.draw do
  root "pages#home"

  resource :sessions, only: [:create, :destroy]

  resource :users, except: %i[new destroy] do
    get "sign_up", action: "new"
    get "sign_in"
  end

  resources :resumes do
    resources :comments, shallow: true, only: %i[create edit update destroy]
  end

  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
end
