class TherapyRequest < ApplicationRecord
  belongs_to :patient
  belongs_to :pshychologist

  enum status: { pending: 0, accepted: 1, cancelled: 2 }
end
