class QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answers.build(params[:answer])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to @question, notice: 'Question was successfully posted.'
    else
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(questions_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
    def questions_params
      params.require(:question).permit(:title, :description)
    end
end
