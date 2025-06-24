class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def profile
  end

  def index
    @psychologists = User.where(role:[1])
  end

  def show
    @psychologist = User.find(params[:id])
  end
end
