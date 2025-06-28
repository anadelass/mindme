class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.where(user_id: current_user.id )
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(params)
    @appointment.user_id = current_user.id
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
end
