Rails.application.routes.draw do

  # static page routes
  root                'static_pages#home'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'news'    => 'static_pages#news'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  # RESTful
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :articles
end
