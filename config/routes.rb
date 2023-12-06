Rails.application.routes.draw do
  resources :users, only: %i[create show update destroy]
  resources :posts, only: %i[create index show update destroy]

  post '/login', to: 'authentication#login'
end
