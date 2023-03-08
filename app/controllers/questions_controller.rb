class QuestionsController < ApplicationController
	# Display all questions pulled from the synced repo
	def index
		if session[:current_user_id].present? and session[:selected_repo].present?
			current_user = User.find(session[:current_user_id])
			if current_user != nil and current_user.repo == session[:selected_repo]
				@questions = Question.where(repo: session[:selected_repo])
			end
		else
			@questions = Question.where(repo: "0")
		end
	end

	def search
		@questions = Question.where("title LIKE ?", "%#{params[:search]}%")
	end
end