Rails.application.routes.draw do
  root "events#index"

  # get "events" => "events#index"
  # post "events" => "events#create"
  # get "events/new" => "events#new", as: "new_event"
  # get "events/:id" => "events#show", as: "event"
  # get "events/:id/edit" => "events#edit", as: "edit_event"
  # patch "events/:id" => "events#update"
  # delete "events/:id" => "events#destroy"
  resources :events
end
