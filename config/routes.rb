Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#welcome"
  get "about", to: "home#about"
  get "contact-us", to: "home#contact_us"
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "signout", to: "sessions#destroy"
  resources :users do
    resources :thoughts
  end
  resources :thoughts, only: [:show, :index] do
    collection do
      post :search
    end
  end
end
