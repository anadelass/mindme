class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment

  def new
    @review = @appointment.build_review
  end

  def create
    @review = @appointment.build_review(review_params)
    @review.patient = current_user
    @review.psychologist = @appointment.psychologist

    if @review.save
      redirect_to appointment_path(@appointment), notice: "Reseña creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comments)
  end
end
