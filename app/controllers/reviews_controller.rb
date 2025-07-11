class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment
  before_action :authorize_patient!

  def new
    if @appointment.review.present?
      redirect_to appointments_path, alert: "You have already submitted a review for this appointment.."
    else
      @review = @appointment.build_review
    end
  end

  def create
    if @appointment.review.present?
      redirect_to appointments_path, alert: "You have already submitted a review for this appointment.."
      return
    end

    @review = @appointment.build_review(review_params)
    @review.patient = current_user
    @review.psychologist = @appointment.psychologist

    if @review.save
      redirect_to appointments_path, notice: "Review sent successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def authorize_patient!
    unless @appointment.patient == current_user
      redirect_to appointments_path, alert: "You are not authorized to review this quote."
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comments)
  end
end
