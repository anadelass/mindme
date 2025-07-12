class QuestionsController < ApplicationController
  def index
    @questions = current_user.questions
    @question = Question.new
  end

  def create
    @questions = current_user.questions
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      GenerateAiAnswerJob.perform_later(@question.id)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('questions-container', partial: "questions/question",
          locals: { question: @question })
        end
        format.html { redirect_to dashboard_path }

      end
    else
    render :index, status: :unprocessable_entity
    end
  end

      def destroy_all
      current_user.questions.destroy_all

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "questions-container",
            partial: "questions/empty_chat"
          )
        end
        format.html { redirect_to dashboard_path, notice: "Chat cleared." }
      end
    end

  private

  def question_params
    params.require(:question).permit(:user_question)
  end
end
