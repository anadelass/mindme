# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🧹 Deleting existing users..."
User.destroy_all

puts "👨‍⚕️ Creating psychologists..."

psychologists = [
  { first_name: "Ana", last_name: "Martinez", email: "anamartinez@gmail.com" },
  { first_name: "Carlos", last_name: "Lopez", email: "carloslopez@gmail.com" },
  { first_name: "Laura", last_name: "Gomez", email: "lauragomez@gmail.com" }
]

psychologists.each do |psych|
  User.create!(
    email: psych[:email],
    password: "password123",
    password_confirmation: "password123",
    first_name: psych[:first_name],
    last_name: psych[:last_name],
    role: :psychologist
  )
end

puts "👤 Creating patient..."

User.create!(
  email: "peteramirez@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  first_name: "Peter",
  last_name: "Ramirez",
  role: :patient
)

puts "✅ Seed completed: 3 psychologists and 1 patient created successfully."
