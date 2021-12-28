Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Sign up
    post "sign-up", to: "users#create"
    # Sign in
    post "sign-in", to: "sessions#create"
    # Personal Page
    get "personal", to: "users#personal"
    # User Page
    get "user", to: "users#user"

    # Entries
    resources :entries, only: %i[index create] do
      collection do
        get "user", to: "entries#index_user"
      end
    end

    # Comments
    resources :comments, only: %i[index create]
  end
end
