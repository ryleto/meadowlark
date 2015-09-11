Rails.application.routes.draw do

  get 'sessions/new'

  # static page routes
  root :to => 'static_pages#home'
  get '/home' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/news' => 'static_pages#news'
  
  # user routes
  resources :users
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
 
end
