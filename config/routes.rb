Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'
  get '/all_repositories', to: 'dashboard#all_repositories'
  get '/recent_commits', to: 'dashboard#recent_commits'
end
