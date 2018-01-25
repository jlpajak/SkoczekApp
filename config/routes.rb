Rails.application.routes.draw do
  
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  resources :articles
  
  get '/signup', to: 'players#new'
  resources :players, except: [:new]
end
