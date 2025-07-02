class Appointment < ApplicationRecord
  belongs_to :patient, class_name: "User"
  belongs_to :psychologist, class_name: "User"

  enum status: { pending: 0, accepted: 1, cancelled: 2 }
  enum format: { in_person: 0, online:1 }

  has_many :psychologist_messages, dependent: :destroy
  validates :scheduled_at, presence: true
end
