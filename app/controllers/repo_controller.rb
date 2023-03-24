# controller to get a list of repos and questions from repo
require 'octokit'

class RepoController < ApplicationController
  # All method require authenticated user
  before_action :require_login!

  def require_login!
    @current_user = User.find(session[:current_user_id]) and return \
        if session[:current_user_id].present?

    # Return to the same page after login
    session[:destination_after_login] = request.env['REQUEST_URI']
    redirect_to login_url
  end

  # Method to get list of repos given a user
  def new
    # Authenticate the user via Octokit
    @client = Octokit::Client.new(:access_token => User.find(session[:current_user_id]).token)
    @user = @client.user
    @user.login
    # Get the list of private repos
    @repos = @client.repos({}, query: {type: 'private', sort: 'full_name', per_page: 100})
  end

  # Method to synchronize or get questions from a selected repo
  def sync
    # Get the repo from the selected dropdown in the views
    @repo = params[:repo_id]

    # Authenticate the user via Octokit
    @client = Octokit::Client.new(:access_token => User.find(session[:current_user_id]).token)
    @user = @client.user
    @user.login

    # Initial path which is defined by PrairieLearn documentations
    path = 'questions'

    # Check cache
    checkCommit(@client, @repo, path)
    session[:selected_repo] = @repo
    User.find(session[:current_user_id]).update(repo: @repo)
    redirect_to root_path
  end

  # Method to check if a repo has been pulled
  def checkCommit(client, repo, path)
    root = client.contents(repo, path: "/")

    # For each directory, check if the commit ID is different
    root.each do |dir|
      if dir.name == path
        repo_commit = Commit.find_by repo: repo
        # If the commit is not found, pull and create commit
        if repo_commit != nil
          if repo_commit.sha == dir.sha
            # If the commit is identical, use the available cached file
            return
          else
            # If the commit is different, destroy record
            Question.destroy_by(repo: repo)
            repo_commit.update(sha: dir.sha)
          end
        else
          Commit.create(sha: dir.sha, repo: repo)
        end
      end
    end
    # Pulling questions via helper method
    addQuestions(client, repo, path)
  end

  # Helper method to get all questions
  def addQuestions(client, repo, path)
    contents = client.contents(repo, path: path)
    contents.each do |file|
      # If .JSON file is found, keep the path
      if file.name == "info.json"
        question_name = file.path.partition('/')[2].rpartition('/')[0]

        require 'json'
        path_str = path+"/info.json"
        path_str = 
        contentsJsonInfobase64 = client.contents(repo, path: path_str)
        require "base64"
        decode_base64_content = Base64.decode64(contentsJsonInfobase64) 
        json_info = JSON.parse(decode_base64_content)
        descriptive_title = json_info["title"]

        Question.create(title: question_name, descriptive_title: descriptive_title, repo: repo, selected: 0)
      end
      # Recursively call the helper method if current file is a folder
      if file.type == 'dir'
        new_path = path + '/' + file.name
        addQuestions(client, repo, new_path)
      end
    end
  end
end
