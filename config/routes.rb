Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  # static page routes
  root :to => 'static_pages#home'
  get '/home' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/news' => 'static_pages#news'
  
  # user routes
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
 
end
