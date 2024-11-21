Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #homepage routes
  get '/homes' => 'homes#index'
  post 'homes' => 'homes#create'

  #Profile Routes
  get '/places' => 'places#index'
  get '/places/:id' => 'places#show'
  patch '/places/:id' => 'places#update'
  post '/places' => 'places#create'
  delete '/places/:id' => 'places#destroy'

  # Defines the root path route ("/")
  root "homes#index"
end
