class GenerateAiAnswerJob < ApplicationJob
  queue_as :default

  def perform(question_id)
    question = Question.find(question_id)
    return if question.ai_answer.present?
    psychologists = User.where(role: "psychologist")
    QuestionResponder.new(question, psychologists).call
  end

  
end
