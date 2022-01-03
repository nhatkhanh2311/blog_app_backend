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
    # Upload Avatar
    post "avatar", to: "users#avatar"
    # Search Users Page
    get "search", to: "users#search"

    # Follow
    post "follow", to: "relationships#follow"
    # Unfollow
    post "unfollow", to: "relationships#unfollow"
    # Get following users
    get "following-users", to: "relationships#following_users"
    # Get followers
    get "followed-users", to: "relationships#followed_users"

    # Entries
    resources :entries, only: %i[index create] do
      collection do
        get "user", to: "entries#index_user"
        get "all", to: "entries#index_all"
      end
    end

    # Comments
    resources :comments, only: %i[index create]
  end
end
