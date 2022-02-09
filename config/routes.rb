Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "filers#index"

  resources :filers
  resources :recipients do
    resources :filings
  end
  resources :filings
end
