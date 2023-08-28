Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"
  get '/users/:id', to: 'users#show'
  get '/users/:id/posts', to: 'posts#index'
  get '/users/:user_id/posts/:id', to: 'posts#show'
end
