PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :users, except: [:destroy] do
    resources :posts
    resources :comments
  end

  resources :posts, except: [:edit, :destroy] do
    resources :comments, only: [:create, :show]
  end
end
