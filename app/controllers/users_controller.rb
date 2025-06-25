class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def profile
    @user = current_user
  end

  def index
    @psychologists = User.where(role:[1])
  end

  def show
    @psychologist = User.find(params[:id])
  end
end
