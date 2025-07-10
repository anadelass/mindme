class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :hide_navbar!, only: [:dashboard, :profile]


  def profile
    @user = current_user
  end

  def index
    @psychologists = User.where(role: [1])
  end

  def show
    @psychologist = User.find(params[:id])
  end

  def dashboard
    @questions = current_user.questions
    @question = Question.new

    if current_user.psychologist?
      @last_appointment = current_user.psychologist_appointments
                                        .joins(:patient)
                                        .order(updated_at: :desc).first
    elsif current_user.patient?
      @last_appointment = current_user.patient_appointments
                                      .joins(:psychologist)
                                      .order(updated_at: :desc).first
    end

    @messages = if @last_appointment
                  PsychologistMessage.where(appointment: @last_appointment).order(created_at: :asc)
                else
                  []
                end

    @message = PsychologistMessage.new


    @psychologist = current_user

    @total_patients = User.where(role: 'patient').count
    @new_patients = User.where(role: 'patient', created_at: Time.zone.today.all_day).count
    @old_patients = @total_patients - @new_patients

    @today_appointments = Appointment.where(scheduled_at: Time.zone.today.all_day)
                                     .includes(:patient)
                                     .map do |appt|
      {
        patient_name: "#{appt.patient.first_name} #{appt.patient.last_name}",
        reason: appt.format,
        time: appt.scheduled_at.strftime("%I:%M %p")
      }
    end

    @top_patients = User.joins(:patient_appointments)
                        .where(role: 'patient')
                        .group("users.id")
                        .select("users.*, COUNT(appointments.id) AS appointments_count")
                        .order("appointments_count DESC")
                        .limit(3)

    @appointments_per_day = Appointment
                              .where("DATE(scheduled_at) >= ?", Date.today - 6)
                              .group("DATE(scheduled_at)")
                              .order("DATE(scheduled_at)")
                              .count

    @therapy_request_statuses = TherapyRequest.group(:status).count

    @busiest_day = Appointment
                     .group("DATE(scheduled_at)")
                     .order(Arel.sql("COUNT(*) DESC"))
                     .limit(1)
                     .pluck("DATE(scheduled_at)")
                     .first
  end

  private

  def hide_navbar!
    @hide_navbar = true
  end

end
