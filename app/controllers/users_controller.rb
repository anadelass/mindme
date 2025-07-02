class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def profile
    @user = current_user
  end

  def index
    @psychologists = User.where(role:[1])
  end

  def show
    @psychologist = User.find(params[:id])
  end

  def dashboard
    @psychologist = current_user
    @total_patients = User.where(role: 'patient').count
    @new_patients = User.where(role: 'patient', created_at: Time.zone.today.all_day).count
    @old_patients = @total_patients - @new_patients

    @today_appointments = Appointment.where(scheduled_at: Time.zone.today.all_day).includes(:patient).map do |appt|
      {
        patient_name: "#{appt.patient.first_name} #{appt.patient.last_name}",
        reason: appt.format,
        time: appt.scheduled_at.strftime("%I:%M %p")
      }
    end
  end
end
