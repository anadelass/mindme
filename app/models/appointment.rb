class Appointment < ApplicationRecord
  belongs_to :patient, class_name: "User"
  belongs_to :psychologist, class_name: "User"

  enum status: { pending: 0, accepted: 1, cancelled: 2 }
  #enum status: { pending: 0, accepted: 1, cancelled: 2 }

end
