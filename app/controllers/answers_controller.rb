class AnswersController < ApplicationController

  # GET /questions/:question_id/answers/new
  # def new
  # #   puts "in new"
  # #   puts params[:question_id]
  # #   @question = Question.find(params[:question_id])
  # #
  # #   puts @question
  # #   # @answer = @question.answers.new
  #    @answer = Answer.new
  #  end
  # POST /questions/:question_id/answers
  def create
    @question = Question.find(params[:question_id])
    # @answer = @question.answers.new(answers_params)
    @answer = Answer.new(answers_params)
    @answer.question = @question

    if @answer.save
      redirect_to question_path(@question), notice: 'Answer was successfully posted.'
    else
      #notice: msg doesn't work with render
      render '/questions/show'
    end
  end

  private
    def answers_params
      params.require(:answer).permit(:description)
    end
end
