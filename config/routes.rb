Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Sign up
    post "sign-up", to: "registrations#create"
    # Sign in
    post "sign-in", to: "sessions#create"
  end
end
