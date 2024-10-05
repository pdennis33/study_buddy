Rails.application.routes.draw do
  get 'home/index'
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
    skip: [:registrations, :sessions, :passwords]
  resources :topics do
    resources :flashcards
    member do
      get 'quiz', to: 'topics#start_quiz'
      get 'quiz/flashcard/:flashcard_id', to: 'topics#quiz', as: 'quiz_flashcard'
      post 'import_flashcards'
    end
  end

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # Defines the root path route ("/")
  root to: "home#index"
end
