class QuestionsController < ApplicationController
	# Display all questions pulled from the synced repo
	def index
		@questions = find_user_repo
	end

	def search
		@questions = find_user_repo
		@search_terms = params[:search]
		@questions = @questions.where("title LIKE :search_terms OR descriptivetitle LIKE :search_terms", search_terms: Question.sanitize_sql_like(params[:search]) + "%")
		respond_to do |format|
			format.html { render partial: 'search_questions' }
		end
	end

	private

	def find_user_repo
		if session[:current_user_id].present? and session[:selected_repo].present?
			current_user = User.find(session[:current_user_id])
			if current_user != nil and current_user.repo == session[:selected_repo]
				questions = Question.where(repo: session[:selected_repo])
			end
		else
			questions = Question.where(repo: "0")
		end
		questions
	end
end
