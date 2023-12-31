Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'comments/index'
      get 'comments/create'
    end
  end
   namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  post '/posts', to: 'posts#create', as: 'posts'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end
  
  resources :posts do
    resources :comments, only: [:create, :new, :destroy]
    resources :likes, only: [:create]
  end

  delete '/posts/:id', to: 'posts#destroy', as: 'destroy_post'

  root "users#index"
end
