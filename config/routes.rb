Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/registration', to: 'users#new'

  get '/dashboard', to: 'users#show'
  get '/discover', to: 'users#index'

  get '/login', to: 'sessions#new'

  resources :users, only: [:create]

  resources :user_friends

end
