class PsychologistMessagesController < ApplicationController
def index
  load_chat_data
end

def create
  session[:sender_id] = params[:psychologist_message][:sender_id]
  @appointment = Appointment.find(params[:appointment_id])
  @message = @appointment.psychologist_messages.new(message_params)

  if current_user.patient?
    @message.patient_id = current_user.id
    @message.psychologist_id = @appointment.psychologist_id
  else
    @message.psychologist_id = current_user.id
    @message.patient_id = @appointment.patient_id
  end

  @message.content += "-#{session[:sender_id]}"
  if @message.save
    @message = PsychologistMessage.new
    respond_to do |format|
      format.html { redirect_to messages_path(appointment_id: @appointment.id) }
      format.turbo_stream { head :ok }
    end
  else
    load_chat_data
    render :index
  end
end

def destroy_chat
  @appointment = Appointment.find(params[:appointment_id])
  @appointment.psychologist_messages.destroy_all

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to messages_path }
  end
end


private

def message_params
  params.require(:psychologist_message).permit(:content)
end

def load_chat_data
  if current_user.psychologist?
    @appointments = current_user.psychologist_appointments.includes(:patient)
  else
    @appointments = current_user.patient_appointments.includes(:psychologist)
  end

  @selected_appointment = @appointments.find_by(id: params[:appointment_id]) || @appointments.last

  if @selected_appointment
    @chat_partner = current_user.psychologist? ? @selected_appointment.patient : @selected_appointment.psychologist
    @user = current_user
    @messages = PsychologistMessage.where(appointment: @selected_appointment).order(:created_at)
    @message = PsychologistMessage.new
  end
end
end
