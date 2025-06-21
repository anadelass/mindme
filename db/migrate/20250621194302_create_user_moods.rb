class CreateUserMoods < ActiveRecord::Migration[7.1]
  def change
    create_table :user_moods do |t|
      t.string :mood
      t.references :ai_chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
