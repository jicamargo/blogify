Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create ] do # Add new and create actions for posts
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end

  # deactive the favicon route in test environment
  get '/favicon.ico', to: proc { [204, {}, []] }

end
