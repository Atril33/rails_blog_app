Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  post '/posts', to: 'posts#create', as: 'posts'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end
  
  resources :posts do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create]
  end

  root "users#index"
end
