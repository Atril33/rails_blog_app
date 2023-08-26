Rails.application.routes.draw do

  post '/posts', to: 'posts#create', as: 'posts'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end
  
  resources :posts do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create]
  end
  # Define the root path route ("/")
  # root "controller_name#action_name"
  # Example: root "users#index"
end
