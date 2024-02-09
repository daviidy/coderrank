Rails.application.routes.draw do
  # get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users, only: [:create]
  namespace :auth do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  resources :challenges
  resources :comments
  resources :cases
  post '/admin', to: 'users#add_admin'
  # create route for challenge_comments in comments controller
  get '/challenge_comments/:challenge_id', to: 'comments#challenge_comments'
end
