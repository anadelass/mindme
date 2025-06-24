class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  enum role: { patient: 0, psychologist: 1 }
  has_one :psychologist_profile
  has_many :patient_appointments, class_name: "Appointment" ,foreign_key: "patient_id", dependent: :destroy
  has_many :psychologist_appointments, class_name: "Appointment" ,foreign_key: "psychologist_id", dependent: :destroy

end
