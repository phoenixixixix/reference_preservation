Rails.application.routes.draw do
  resources :links, except: %i[ show ]
  resources :groups
  root "pages#home"
end
