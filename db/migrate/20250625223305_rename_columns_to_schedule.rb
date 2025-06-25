class RenameColumnsToSchedule < ActiveRecord::Migration[7.1]
  def change
    # Renombrar columnas
    rename_column :schedules, :day_available, :date
    rename_column :schedules, :time_min_avalaible, :start_hour
    rename_column :schedules, :time_max_available, :end_hour

    # Cambiar tipos con conversión explícita
    change_column :schedules, :date, :date, using: 'date::date'
    change_column :schedules, :start_hour, :time, using: 'start_hour::time'
    change_column :schedules, :end_hour, :time, using: 'end_hour::time'
  end
end
