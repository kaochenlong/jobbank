Rails.application.routes.draw do
  delete '/resumes/:id', to: 'resumes#destroy'
  patch '/resumes/:id', to: 'resumes#update'
  get '/resumes/:id/edit', to: 'resumes#edit', as: 'edit_resume'
  get '/resumes/new', to: 'resumes#new', as: 'new_resume'
  get '/resumes/:id', to: 'resumes#show', as: 'resume'
  get '/resumes', to: 'resumes#index'
  post '/resumes', to: 'resumes#create'

  root 'pages#home'
  # get '/', to: 'pages#home', as: 'root'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
end
