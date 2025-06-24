Rails.application.routes.draw do
  devise_for :users
  resources :ai_chats, only: [ :create ] do
    resources :ai_chat_messages, only: [ :index, :create ]
  end
  get 'users/profile', to: 'user#profile'
  get 'psychologists', to: 'users#index'
  get 'psychologists/:id', to: 'users#show'
  resources :schedules
  resources :therapy_requests, only: [ :create ]
  resources :appointments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
