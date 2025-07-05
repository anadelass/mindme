class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  enum role: { patient: 0, psychologist: 1 }
  has_one :psychologist_profile
  has_many :psychologist_therapy_requests, class_name: "TherapyRequest" ,foreign_key: "psychologist_id", dependent: :destroy
  has_many :patient_therapy_requests, class_name: "TherapyRequest" ,foreign_key: "patient_id", dependent: :destroy

  has_many :patient_appointments, class_name: "Appointment" ,foreign_key: "patient_id", dependent: :destroy
  has_many :psychologist_appointments, class_name: "Appointment" ,foreign_key: "psychologist_id", dependent: :destroy

  has_many :psychologist_messages_as_patient, class_name: "PsychologistMessage", foreign_key: "patient_id"
  has_many :psychologist_messages_as_psychologist, class_name: "PsychologistMessage", foreign_key: "psychologist_id"

  has_one_attached :avatar
end

