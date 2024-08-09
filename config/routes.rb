Rails.application.routes.draw do
  resources :topics do
    resources :flashcards
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "topics#index"
end
