class ChoicesController < ApplicationController
before_action :authenticate_user
  def create
	 @question = Question.find(params[:question])
	 text = params[:text]
	 correct = params[:correct] == "1"
	 new = Choice.create(:text => text, :correct => correct, :question_id => @question.id)

	 if new.correct
		@question.answer = new
	 end

	 redirect_to question_path(@question)
  end

  def destroy
	 @question = Question.find(params[:question])
	 @choice = Choice.find(params[:choice])
	 @choice.destroy
	 redirect_to question_path(@question)
  end
end
