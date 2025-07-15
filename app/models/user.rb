class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_neighbors :embedding
  after_create :set_embedding

  has_one :psychologist_profile, dependent: :destroy
  accepts_nested_attributes_for :psychologist_profile


  enum role: { patient: 0, psychologist: 1 }
  has_one :psychologist_profile
  has_many :psychologist_therapy_requests, class_name: "TherapyRequest" ,foreign_key: "psychologist_id", dependent: :destroy
  has_many :patient_therapy_requests, class_name: "TherapyRequest" ,foreign_key: "patient_id", dependent: :destroy

  has_many :patient_appointments, class_name: "Appointment" ,foreign_key: "patient_id", dependent: :destroy
  has_many :psychologist_appointments, class_name: "Appointment" ,foreign_key: "psychologist_id", dependent: :destroy

  has_many :psychologist_messages_as_patient, class_name: "PsychologistMessage", foreign_key: "patient_id"
  has_many :psychologist_messages_as_psychologist, class_name: "PsychologistMessage", foreign_key: "psychologist_id"

  has_many :given_reviews, class_name: 'Review', foreign_key: 'patient_id', dependent: :destroy
  has_many :received_reviews, class_name: 'Review', foreign_key: 'psychologist_id', dependent: :destroy

  has_many :questions
  has_one_attached :avatar


    def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "First name: #{first_name}. Last name #{last_name} Role: #{role}"
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding: embedding)
    end
end
