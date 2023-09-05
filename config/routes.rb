Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :destroy_user_session
  end
  
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create ] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end
end
