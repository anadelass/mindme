class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_up_path_for(resource)
    dashboard_path
  end

  protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [
    :first_name, :last_name, :role, :avatar,
    psychologist_profile_attributes: [:bio, :experience, :modelity]
  ])
  devise_parameter_sanitizer.permit(:account_update, keys: [
    :first_name, :last_name, :avatar
  ])
end
end
