Rails.application.routes.draw do
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"

  resources :links, except: %i[ show ]
  resources :groups, except: %i[ show ]

  root "links#index"
end
