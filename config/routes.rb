Rails.application.routes.draw do
  resources :likes
  root "events#index"

  resources :events do
    resources :registrations
  end

  resources :users
  get "signup" => "users#new"

  # Notice this is all in singular form, we don't need to specify the id
  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
end
