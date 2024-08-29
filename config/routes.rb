Rails.application.routes.draw do
  resources :topics do
    resources :flashcards
    member do
      get 'quiz', to: 'topics#start_quiz'
      get 'quiz/flashcard/:flashcard_id', to: 'topics#quiz', as: 'quiz_flashcard'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "topics#index"
end
