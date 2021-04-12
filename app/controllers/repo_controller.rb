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
    addQuestions(@client, @repo, path)
    redirect_to root_path
  end

  def addQuestions(client, repo, path)
    contents = client.contents(repo, path: path)
    session[:selected_repo] = repo
    contents.each do |file|
      if file.name == "info.json"
        question_name = file.path.partition('/')[2].rpartition('/')[0]
        if !Question.exists?(title: question_name, user_id: session[:current_user_id], repo: repo)
          Question.create(title: question_name, user_id: session[:current_user_id], repo: repo)
        end
      end
      if file.type == 'dir'
        new_path = path + '/' + file.name
        addQuestions(client, repo, new_path)
      end
    end
  end
end
