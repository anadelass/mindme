class TherapyRequest < ApplicationRecord
  belongs_to :patient
  belongs_to :pshychologist
end
