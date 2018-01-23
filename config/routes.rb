Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get '/articles', to: 'articles#index'
  get '/articles/new', to: 'articles#new', as: 'new_article'
  get 'articles/:id', to: 'articles#show', as: 'article'
end
