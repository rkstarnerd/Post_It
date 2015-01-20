PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, except: [:destroy] do
    resources :posts
    resources :comments, only: [:create, :show]
  end

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
    member do 
      post :vote
    end
    colletion do
      get :archives
    end
  end

  resources :categories, except: [:edit, :update, :destroy] do
    resources :posts
  end

  #resources :votes, only: [:create] # alternative to below
end
