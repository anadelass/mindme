# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_05_202716) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "ai_chat_messages", force: :cascade do |t|
    t.bigint "ai_chat_id", null: false
    t.string "ai_answer"
    t.string "user_question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_chat_id"], name: "index_ai_chat_messages_on_ai_chat_id"
  end

  create_table "ai_chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ai_chats_on_user_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "psychologist_id", null: false
    t.date "scheduled_at"
    t.integer "format"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["psychologist_id"], name: "index_appointments_on_psychologist_id"
  end

  create_table "psychologist_messages", force: :cascade do |t|
    t.text "content"
    t.bigint "patient_id", null: false
    t.bigint "psychologist_id", null: false
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_psychologist_messages_on_appointment_id"
    t.index ["patient_id"], name: "index_psychologist_messages_on_patient_id"
    t.index ["psychologist_id"], name: "index_psychologist_messages_on_psychologist_id"
  end

  create_table "psychologist_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "bio"
    t.string "experience"
    t.string "modelity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_psychologist_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "user_question"
    t.text "ai_answer"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.time "start_hour"
    t.time "end_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "therapy_requests", force: :cascade do |t|
    t.integer "status"
    t.bigint "patient_id", null: false
    t.bigint "psychologist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_therapy_requests_on_patient_id"
    t.index ["psychologist_id"], name: "index_therapy_requests_on_psychologist_id"
  end

  create_table "user_moods", force: :cascade do |t|
    t.string "mood"
    t.bigint "ai_chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_chat_id"], name: "index_user_moods_on_ai_chat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.vector "embedding", limit: 1536
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ai_chat_messages", "ai_chats"
  add_foreign_key "ai_chats", "users"
  add_foreign_key "appointments", "users", column: "patient_id"
  add_foreign_key "appointments", "users", column: "psychologist_id"
  add_foreign_key "psychologist_messages", "appointments"
  add_foreign_key "psychologist_messages", "users", column: "patient_id"
  add_foreign_key "psychologist_messages", "users", column: "psychologist_id"
  add_foreign_key "psychologist_profiles", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "schedules", "users"
  add_foreign_key "therapy_requests", "users", column: "patient_id"
  add_foreign_key "therapy_requests", "users", column: "psychologist_id"
  add_foreign_key "user_moods", "ai_chats"
end
