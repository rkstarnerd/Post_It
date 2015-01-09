PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :users, except: [:destroy] do
    resources :posts
    resources :comments, only: [:create, :show]
  end

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create, :show]
  end

  resources :categories, except: [:edit, :update, :destroy] do
    resources :posts
  end
end
