require "omniauth"

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer if Rails.env.development?
    provider :github, Rails.application.credentials.github[:github_client_id], Rails.application.credentials.github[:github_client_secret], scope: "read:org,read:repo_hook,repo,user", :provider_ignores_state => true
end
