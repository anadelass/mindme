class CreatePsychologistMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :psychologist_messages do |t|
      t.text :content
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :psychologist, null: false, foreign_key: { to_table: :users }
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
