Rails.application.routes.draw do
  resources :game_events
  resources :game_events, path: "api/user/game_events"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "api/health"
  post "api/user"
  get "api/user", to: "api#details"
  post "api/sessions" , to: "sessions#create"
end
