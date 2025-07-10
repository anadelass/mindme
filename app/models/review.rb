class Review < ApplicationRecord
  belongs_to :patient, class_name: 'User'
  belongs_to :psychologist, class_name: 'User'
  belongs_to :appointment

  validates :rating, inclusion: { in: 1..5 }
  validates :appointment_id, uniqueness: true
end
