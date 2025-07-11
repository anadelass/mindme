class PsychologistMessage < ApplicationRecord
  belongs_to :patient, class_name: "User"
  belongs_to :psychologist, class_name: "User"
  belongs_to :appointment

  validates :content, presence: true

  after_create_commit do
    broadcast_append_to(
      "chat_#{appointment.id}",
      target: "messages",
      partial: "psychologist_messages/message",
      locals: { message: self }
    )
  end
end
