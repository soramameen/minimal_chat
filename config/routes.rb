Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "set_name", to: "sessions#create"

  root "rooms#index"

  resources :rooms, only: [ :index, :show, :create ] do
    resources :messages, only: [ :create ]
  end

  # For update/destroy, we can keep top-level messages or nested.
  # Since existing controller has them, let's keep them accessible but maybe we don't need them for this feature yet.
  # But the existing tests use them. Let's keep them for now to minimize breakage of existing functionality if desired.
  # But 'index' of messages is gone.
  resources :messages, only: [ :edit, :update, :destroy ]
end
