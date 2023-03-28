Rails.application.routes.draw do
  get '/resumes/:id', to: 'resumes#show', as: 'resume'
  get '/resumes', to: 'resumes#index'
  get '/resumes/new', to: 'resumes#new', as: 'new_resume'
  post '/resumes', to: 'resumes#create'

  root 'pages#home'
  # get '/', to: 'pages#home', as: 'root'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
end
