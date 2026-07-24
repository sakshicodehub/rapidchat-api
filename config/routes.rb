Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      post "auth/send_otp"
      post "auth/verify_otp"

      post "auth/refresh"

      delete "auth/logout"

      resources :users

      resources :chats
      resources :messages
      resources :message_receipts
      resources :chat_members
      resources :contacts
      resources :chat_members
    end
  end
  mount ActionCable.server => "/cable"
  # Defines the root path route ("/")
  root to: "health#show"
end
