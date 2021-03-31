Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/registration', to: 'users#new'

  get '/dashboard', to: 'users#show'
  get '/discover', to: 'users#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'

  get '/viewing_parties/new', to: 'viewing_parties#new'
  post '/viewing_parties', to: 'viewing_parties#create'
  get '/viewing_parties', to: 'viewing_parties#index'

  resources :users, only: [:create]
  resources :user_friends
end
