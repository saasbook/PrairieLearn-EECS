require 'octokit'

class RepoController < ApplicationController
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

  def sync
    @repo = params[:repo_id]
    @client = Octokit::Client.new(:access_token => User.find(session[:current_user_id]).token)
    @user = @client.user
    @user.login
    path = 'questions'
    @content = traverseHelper(@client, @repo, path)
  end

  def traverseHelper(client, repo, path)
    contents = client.contents(repo, path: path)
    name = []
    contents.each do |file|
      name.append(file.name)
      if file.type == 'dir'
        new_path = path + '/' + file.name
        name.append(traverseHelper(client, repo, new_path))
      end
    end
    return name
  end
end
