require 'octokit'

class ContentController < ApplicationController
  before_action :require_login!

  def require_login!
    @current_user = User.find(session[:current_user_id]) and return \
        if session[:current_user_id].present?

    session[:destination_after_login] = request.env['REQUEST_URI']
    redirect_to login_url
  end

  def new
    @client = Octokit::Client.new(:access_token => User.find(session[:current_user_id]).token)
    @user = @client.user
    @user.login
    @repos = @client.repos({}, query: {type: 'all', sort: 'full_name'})
  end
end
