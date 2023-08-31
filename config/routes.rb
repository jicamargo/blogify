Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create ] # Add new and create actions for posts
  end

  # Add routes for comments and likes
  resources :comments, only: [:create]
  resources :likes, only: [:create]
end
