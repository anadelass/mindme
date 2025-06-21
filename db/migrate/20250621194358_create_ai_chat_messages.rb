class CreateAiChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_chat_messages do |t|
      t.references :ai_chat, null: false, foreign_key: true
      t.string :ai_answer
      t.string :user_question

      t.timestamps
    end
  end
end
