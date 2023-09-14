Rails.application.routes.draw do
  resources :links, except: %w(show)
  resources :groups
  root "pages#home"
end
