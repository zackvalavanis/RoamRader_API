Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #homepage routes
  get '/homes' => 'homes#index'
  post 'homes' => 'homes#create'

  #Profile Routes
  get '/cities' => 'cities#index'
  get '/cities/:id' => 'cities#show'
  patch '/cities/:id' => 'cities#update'
  post '/cities' => 'cities#create'
  delete '/cities/:id' => 'cities#destroy'

  # Defines the root path route ("/")
  root "homes#index"

  #sessions route
  post '/sessions' => 'sessions#create'

  #users
  post "/users" => "users#create"
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  delete '/users/:id' => 'users#destroy'

  #comments 
  get '/comments' => 'comments#index'
  get '/comments/:id' => 'comments#show'
  patch '/comments/:id' => 'comments#update'
  post '/comments' => 'comments#create'
  delete '/comments/:id' => 'comments#destroy'
  #Root
  # root "users#index"
end
