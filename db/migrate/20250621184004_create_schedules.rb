class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.string :day_available
      t.string :time_min_avalaible
      t.string :time_max_available

      t.timestamps
    end
  end
end
