Rails.application.routes.draw do
  
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  resources :articles do
    resources :comments, only: [:create]
    member do 
      post 'like'
    end
  end
  
  get '/signup', to: 'players#new'
  resources :players, except: [:new]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :tags, except: [:destroy]
  
  mount ActionCable.server => '/cable'
  
  get '/chat', to: 'chatrooms#show'
  
  resources :messages, only: [:create]
  
end
