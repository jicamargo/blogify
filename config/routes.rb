Rails.application.routes.draw do
  # mount Rswag::Ui::Engine => '/api-docs'
  # mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end
  
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end

  resources :posts do
    member do
      delete 'delete', to: 'posts#destroy', as: 'delete_post'
    end
  end

  resources :comments do
    member do
      delete 'delete', to: 'comments#destroy', as: 'delete_comment'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :show, :new, :create]
        end
      end
    end
  end

  # deactive the favicon route in test environment
  get '/favicon.ico', to: proc { [204, {}, []] }

  # routes for swagger documentation
  # if Rails.env.development?
  #   mount SwaggerUiEngine::Engine, at: '/api-docs'
  # end
end
