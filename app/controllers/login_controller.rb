# login controller
class LoginController < ApplicationController
  before_action :already_logged_in, except: [:logout]

  def github
    create_session(:create_github_user)
  end

  def home
    if session[:current_user_id].present?
      redirect_to user_profile_path
    end
  end

  def logout
    session[:current_user_id] = nil
    redirect_to home_path, notice: 'You have successfully logged out.'
  end

  private

  # All methods below could be simplified if no other provider will be added

  def create_session(create_if_not_exists)
    user_info = request.env['omniauth.auth']
    user = find_or_create_user(user_info, create_if_not_exists)
    session[:current_user_id] = user.id
    destination_url = session[:destination_after_login] || repo_path
    session[:destination_after_login] = nil
    redirect_to destination_url
  end

  def find_or_create_user(user_info, create_if_not_exists)
    provider_sym = user_info['provider'].to_sym
    user = User.find_by(
      provider: User.providers[provider_sym],
      uid: user_info['uid']
    )
    return user unless user.nil?

    send(create_if_not_exists, user_info)
  end

  def create_github_user(user_info)
    User.create(
      uid: user_info['uid'],
      provider: User.providers[:github],
      email: user_info['info']['email'],
      token: user_info['credentials']['token']
    )
  end

  def already_logged_in
    redirect_to user_profile_path, notice: 'You are already logged in. Logout to switch accounts.'\
        if session[:current_user_id].present?
  end
end
