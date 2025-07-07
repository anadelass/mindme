class TherapyRequest < ApplicationRecord
  belongs_to :patient, class_name: "User"
  belongs_to :psychologist, class_name: "User"

  enum status: { pending: 0, accepted: 1, cancelled: 2 }
  # after_updated_commit :status_changed, if: :saved_change_to_status

  def status_changed
    # Turbo::StreamsChannel.broadcast_update_to(
    #   "question_#{@question.id}",
    #   target: "question_#{@question.id}",
    #   partial: "questions/question", locals: { question: question })

      Turbo::StreamsChannel.broadcast_replace_to(
        "user_#{patient.id}",
        target: "therapy_request_#{id}",
        partial: "therapy_requests/therapy_request",
        locals: { request: self }
      )
  end
end
