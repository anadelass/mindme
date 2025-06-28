class TherapyRequestsController < ApplicationController

  def create
    TherapyRequest.create(patient_id: current_user.id, psychologist_id: params[:psychologist_id], status: 0)
    redirect_to requests_path
  end

  def update
    @request = TherapyRequest.find(params[:id])
    @request.status = 1
    @request.save
    redirect_to requests_path
  end

  def destroy
    @request = TherapyRequest.find(params[:id])
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  def requests
    if current_user.role == "patient"
      @requests = current_user.patient_therapy_requests
    else
      @requests = TherapyRequest.where(psychologist_id: current_user.id)
    end
  end
end
