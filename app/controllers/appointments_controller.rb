class AppointmentsController < ApplicationController
  def index
    if current_user.role == "psychologist"
      @appointments = Appointment.where(psychologist_id: current_user.id).order(scheduled_at: :asc)
    else
      @appointments = Appointment.where(patient_id: current_user.id).order(scheduled_at: :asc)
    end
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
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment status updated."
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(:scheduled_at, :format, :status)
  end
end
