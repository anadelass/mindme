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
  end
end
