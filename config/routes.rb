Rails.application.routes.draw do
  get "users/new"
  get "users/create"
  get "home/index"
  resources :artists, only: [ :index, :show, :new, :create ]
  resources :tracks,  only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :samples, only: [ :new, :create ]

  get "/dashboard", to: "dashboard#index"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  # session routes
  get "login",  to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # health check
  get "up" => "rails/health#show", as: :rails_health_check

  # ("/") makes root dashboard
  root "home#index"
end
