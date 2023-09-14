Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :links

  get "/home", to: "pages#home"
  root "pages#home"
end
