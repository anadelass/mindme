class PsychologistMessage < ApplicationRecord
  belongs_to :patient, class_name: "User"
  belongs_to :psychologist, class_name: "User"
  belongs_to :appointment

  validates :content, presence: true
end
