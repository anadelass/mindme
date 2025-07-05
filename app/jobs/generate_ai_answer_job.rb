class GenerateAiAnswerJob < ApplicationJob
  queue_as :default

  def perform(question_id)
    question = Question.find(question_id)
    return if question.ai_answer.present?

    QuestionResponder.new(question).call
  end
end
