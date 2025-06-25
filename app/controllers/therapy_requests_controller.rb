class TherapyRequestsController < ApplicationController
  def create
    TherapyRequest.create(patient_id: current_user.id, psychologist_id: params[:psychologist_id], status: 0)
    redirect_to requests_path
  end

  def update
    @request = TherapyRequest.find(params[:id])
    @request.status = 2
    @request.save
    redirect_to requests_path
  end

  def destroy
    @request = TherapyRequest.find(params[:id])
    @request.destroy
    redirect_to requests_path, status: :see_other
  end

  def requests
    @requests = current_user.patient_therapy_requests
  end
end
