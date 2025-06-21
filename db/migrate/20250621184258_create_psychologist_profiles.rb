class CreatePsychologistProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :psychologist_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bio
      t.string :experience
      t.string :modelity

      t.timestamps
    end
  end
end
