class RenamePshychologistToPsychologistInTherapyRequets < ActiveRecord::Migration[7.1]
  def change
    rename_column :therapy_requests, :pshychologist_id, :psychologist_id
  end
end
