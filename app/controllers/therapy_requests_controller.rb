class TherapyRequestsController < ApplicationController
  def create
    TherapyRequest.create(patient_id: current_user.id, psychologist_id: params[:psychologist_id], status: 0)
    redirect_to root_path
  end

  def update
  end

  def destroy
  end
end
