Rails.application.routes.draw do
  resources :links, except: %i[ show ]
  resources :groups, except: %i[ show ]
  root "pages#home"
end
