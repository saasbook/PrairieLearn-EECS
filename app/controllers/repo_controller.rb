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
    @repos = @client.repos({}, query: {type: 'private', sort: 'full_name', per_page: 100})
  end

  def sync
    @repo = params[:repo_id]
    @client = Octokit::Client.new(:access_token => User.find(session[:current_user_id]).token)
    @user = @client.user
    @user.login
    path = 'questions'
    checkCommit(@client, @repo, path)
    session[:selected_repo] = @repo
    redirect_to root_path
  end

  def checkCommit(client, repo, path)
    root = client.contents(repo, path: "/")
    root.each do |dir|
      if dir.name == path
        repo_commit = Commit.find_by repo: repo
        if repo_commit != nil
          if repo_commit.sha == dir.sha
            return
          else
            Question.destroy_by(repo: repo)
            repo_commit.sha = dir.sha
          end
        else
          Commit.create(sha: dir.sha, repo: repo)
        end
      end
    end
    addQuestions(client, repo, path)
  end

  def addQuestions(client, repo, path)
    contents = client.contents(repo, path: path)
    contents.each do |file|
      if file.name == "info.json"
        question_name = file.path.partition('/')[2].rpartition('/')[0]
        Question.create(title: question_name, user_id: session[:current_user_id], repo: repo)
      end
      if file.type == 'dir'
        new_path = path + '/' + file.name
        addQuestions(client, repo, new_path)
      end
    end
  end
end
