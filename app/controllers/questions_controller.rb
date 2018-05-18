class QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to @question, notice: 'Question was successfully posted.'
    else
      render 'new'
    end
  end


  private
    def questions_params
      params.require(:question).permit(:title, :description)
    end
end
