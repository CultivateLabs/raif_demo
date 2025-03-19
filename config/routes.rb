Rails.application.routes.draw do
  resources :documents
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resource :chat, only: [ :show ]
  resources :passwords, param: :token

  mount Raif::Engine => "/raif"

  # Defines the root path route ("/")
  root "application#landing"
end
