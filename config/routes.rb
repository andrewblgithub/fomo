Rails.application.routes.draw do
  resources :groups do
    resources :events
    resources :chats
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
