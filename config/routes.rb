Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :projects do
    member do
      get 'add_to_whitelist'
      post 'add_to_whitelist'
    end
    resources :comments, only: [:create]
  end

  # Defines the root path route ("/")
  root "dashboard#index"
end
