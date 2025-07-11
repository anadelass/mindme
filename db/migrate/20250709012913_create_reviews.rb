class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :patient_id, null: false
      t.integer :psychologist_id, null: false
      t.text :comments
      t.integer :rating
      t.integer :appointment_id

      t.timestamps
    end

    add_foreign_key :reviews, :users, column: :patient_id
    add_foreign_key :reviews, :users, column: :psychologist_id
    add_foreign_key :reviews, :appointments
    add_index :reviews, :patient_id
    add_index :reviews, :psychologist_id
    add_index :reviews, :appointment_id
  end
end
