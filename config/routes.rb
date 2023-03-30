Rails.application.routes.draw do
  root "pages#home"

  # GET /users/sign_in
  # POST /users/....
  # Cookie

  # get https://facebook.com
  # cookie -> session

  resource :sessions, only: [:create, :destroy]

  # /users/sign_in

  resource :users, except: %i[new destroy] do
    get "sign_up", action: "new"
    get "sign_in"
  end

  resources :resumes

  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
end
