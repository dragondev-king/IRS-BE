Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "filers#index"

  resources :filers do
    resources :filings do
      resources :awards
    end
  end
  
  resources :recipients do
    resources :filings do
      resources :awards
    end
  end

  resources :filings do
    resources :awards
  end

  resources :awards
end
