class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users}
      t.references :psychologist, null: false, foreign_key: { to_table: :users}
      t.date :scheduled_at
      t.integer :format
      t.integer :status

      t.timestamps
    end
  end
end
