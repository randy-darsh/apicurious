Rails.application.routes.draw do
  root 'welcome#index'
  get '/dashboard', to: 'dashboard#show'

  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
