Rails.application.routes.draw do
  devise_for :users
  resources :ai_chats, only: [ :create ] do
    resources :ai_chat_messages, only: [ :index, :create ]
  end
  get 'users/profile', to: 'user#profile'
  get '/requests', to: 'therapy_requests#requests'
  get "/messages(/:appointment_id)", to: "psychologist_messages#index", as: :messages

  resources :psychologists, only: [ :index, :show ], controller: "users" do
    resources :appointments, only: [ :new, :create ]
  end
resources :appointments, except: [:new, :create] do
  delete :destroy_conversation, on: :member
  resources :psychologist_messages, only: [:index, :create] do
    delete :destroy_chat, on: :collection
  end
end
  resources :schedules
  resources :therapy_requests, only: [ :create, :update, :destroy ]
  resources :questions, only: [:index, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
  get "/dashboard", to: "users#dashboard"
end
