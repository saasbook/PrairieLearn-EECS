class QuestionsController < ApplicationController
	# Display all questions pulled from the synced repo
	def index
		if session[:current_user_id].present? and session[:selected_repo].present?
			@questions = Question.where(user_id: session[:current_user_id], repo: session[:selected_repo])
		else
			@questions = Question.where(user_id: "0", repo: "0")
		end
	end
end