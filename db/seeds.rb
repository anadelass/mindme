puts "🧹 Deleting existing users and psychologist profiles..."
PsychologistProfile.destroy_all
User.destroy_all

puts "👨‍⚕️ Creating psychologists with profiles..."

psychologists = [
  {
    first_name: "Ana", last_name: "Martinez", email: "anamartinez@gmail.com",
    bio: "Specialist in cognitive-behavioral therapy.",
    experience: "5 years of experience with teenagers.",
    modelity: "In-person and online"
  },
  {
    first_name: "Carlos", last_name: "Lopez", email: "carloslopez@gmail.com",
    bio: "Clinical psychologist focused on adults.",
    experience: "10 years of individual therapy.",
    modelity: "Online"
  },
  {
    first_name: "Laura", last_name: "Gomez", email: "lauragomez@gmail.com",
    bio: "Humanistic psychotherapist.",
    experience: "7 years working with anxiety management.",
    modelity: "In-person"
  }
]

psychologists.each do |psych|
  user = User.create!(
    email: psych[:email],
    password: "password123",
    password_confirmation: "password123",
    first_name: psych[:first_name],
    last_name: psych[:last_name],
    role: :psychologist
  )

  PsychologistProfile.create!(
    user: user,
    bio: psych[:bio],
    experience: psych[:experience],
    modelity: psych[:modelity]
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

puts "✅ Seed completed: 3 psychologists with profiles and 1 patient created successfully."
