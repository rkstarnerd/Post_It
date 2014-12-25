PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :users do
    resources :posts
    resources :comments
  end

  resources :posts do
    resources :comments
  end
end
