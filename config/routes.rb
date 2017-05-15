Rails.application.routes.draw do
  resources :groups do
    resources :events
    resources :messages
  end
end
