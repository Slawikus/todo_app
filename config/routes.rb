Rails.application.routes.draw do

  post 'login', to: 'login#create'

  resources :tasks
  resources :users

end
