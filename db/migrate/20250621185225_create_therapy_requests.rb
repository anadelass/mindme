class CreateTherapyRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :therapy_requests do |t|
      t.integer :status
      t.references :patient, null: false, foreign_key: { to_table: :users}
      t.references :pshychologist, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
