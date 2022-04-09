Rails.application.routes.draw do
  root 'events#index'

  resources :events do
    resources :registrations
    resources :likes, only: %i[create destroy]
  end

  resources :users
  get 'signup' => 'users#new'

  # Notice this is all in singular form, we don't need to specify the id
  resource :session, only: %i[new create destroy]
  get 'signin' => 'sessions#new'
end
