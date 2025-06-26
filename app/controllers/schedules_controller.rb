class SchedulesController < ApplicationController
  before_action :psychologist_permit

  def index
    @schedules = Schedule.where(user_id: current_user.id )
  end

  def show
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to schedules_path
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

  def schedule_params
    params.require(:schedule).permit(:date, :start_hour, :end_hour)
  end

  def psychologist_permit
    redirect_to root_path unless current_user.role == "psychologist"
  end
end
