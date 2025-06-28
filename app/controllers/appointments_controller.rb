class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.where(user_id: current_user.id )
  end

  def show
  end

  def new
    @appointment = Appointment.new
    @psychologist = User.find(params[:psychologist_id])
  end

  def create
  @appointment = Appointment.new(appointment_params)
  @appointment.patient_id = current_user.id
  @appointment.psychologist_id = params[:psychologist_id]

    if @appointment.save
      redirect_to appointments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(:scheduled_at, :format, :status)
  end
end
