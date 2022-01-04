Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#welcome"
  get "about", to: "home#about"
  get "contact-us", to: "home#contact_us"
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#sign_in"
  resources :users
end
