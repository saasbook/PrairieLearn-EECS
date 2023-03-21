class QuestionsController < ApplicationController
	# Display all questions pulled from the synced repo
	def index
		@selected_questions = []
		if session[:current_user_id].present? and session[:selected_repo].present?
			current_user = User.find(session[:current_user_id])
			if current_user != nil and current_user.repo == session[:selected_repo]
				@questions = Question.where(repo: session[:selected_repo], selected: 0)
				@selected_questions = Question.where(repo: session[:selected_repo], selected: 1)
			end
		else
			@questions = Question.where(repo: "0")
		end
	end

	def search
		@search_terms = params[:search]
		@questions = Question.where("title LIKE ?", "%#{@search_terms}%").where("selected LIKE ?",false)
		@selected_questions = Question.where(repo: session[:selected_repo], selected: 1)

		if @questions.empty?
			@empty_search = true
			@questions = Question.where(repo: session[:selected_repo], selected: 0)
		else
			@empty_search = false
		end
	end

	def choose
		#Sets the selected parameter to either true or false

		@question = Question.find_by(title: params[:title])
		@question.selected = params[:selected]
		@question.save
	  
		if @question.save
		  # if the task was updated successfully, respond with a success message
		  render json: { status: :ok }
		else
		  # if there was an error updating the task, respond with an error message
		  render json: { status: :unprocessable_entity }
		end
	  end
end