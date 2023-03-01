Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions
  root to: 'login#home', as: 'root'

  get '/home' => 'login#home', :as => :home
  get '/login' => 'login#login', :as => :login
  get '/login/github', to: redirect('auth/github'), as: :github_login
  #get '/auth/github', to: redirect('https://github.com/login/oauth/authorize?client_id=d36b4b79090aea0d2c4d')
  match '/auth/github/callback', to: 'login#github', as: :github_callback, via: [:get, :post]
  get '/logout' => 'login#logout', :as => :logout
  get '/user/profile', to: 'questions#index', as: :user_profile
  get '/repo', to: 'repo#new', as: 'repo'
  get '/sync', to: 'repo#sync', as: 'sync'

  #post '/auth/github/callback', to: 'login#github'
end
