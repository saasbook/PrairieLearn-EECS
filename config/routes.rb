Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions
  root to: 'questions#index', as: 'root'

  get '/home' => 'login#home', :as => :home
  get '/login' => 'login#login', :as => :login
  get '/dummylogin' => 'login#dummylogin', :as => :dummylogin
  get '/login/github', to: redirect('auth/github'), as: :github_login
  get '/auth/github/callback', to: 'login#github', as: :github_callback
  get '/logout' => 'login#logout', :as => :logout
  get '/user/profile', to: 'user#profile', as: :user_profile


  post '/auth/github/callback', to: 'login#github'
end
