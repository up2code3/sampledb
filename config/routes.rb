Rails.application.routes.draw do
  resources :artists, only: [ :index, :show, :new, :create ]
  resources :tracks,  only: [ :index, :show, :new, :create, :edit, :update, :destroy ]

  get "/dashboard", to: "dashboard#index"

  # session routes
  get "login",  to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # health check
  get "up" => "rails/health#show", as: :rails_health_check

  # ("/") makes root dashboard
  root "dashboard#index"
end
