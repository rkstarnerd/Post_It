PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get  '/register',        to: 'users#new'
  get  '/login',           to: 'sessions#new'
  post '/login',           to: 'sessions#create'
  get  '/logout',          to: 'sessions#destroy'
  get  '/forgot_password', to: 'sessions#forgot_password'
  post '/forgot_password', to: 'sessions#reset_password'
  get  '/pin',              to: 'sessions#pin'
  post '/pin',             to: 'sessions#pin'

  match '/auth/:provider/callback' => 'sessions#create_omniauth', via: :get

  resources :users, except: [:destroy] do
    resources :posts
    resources :comments, only: [:create, :show]
  end

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
    member do
      post :vote
    end
  end

  resources :categories, except: [:edit, :update, :destroy] do
    resources :posts
  end

  resources :comments, only: [:vote] do
    member do
      post :vote
    end
  end
end
