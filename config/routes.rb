Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #resources :questions
  root to: 'login#home', as: 'root'

  get '/home' => 'login#home', :as => :home
  get '/login/github', to: redirect('auth/github'), as: :github_login
  match '/auth/github/callback', to: 'login#github', as: :github_callback, via: [:get, :post]
  get '/logout' => 'login#logout', :as => :logout
  get '/user/profile', to: 'questions#index', as: :user_profile
  get '/repo', to: 'repo#new', as: 'repo'
  get '/sync', to: 'repo#sync', as: 'sync'
  post 'questions/search', to: 'questions#search', as: 'search_questions'
end
