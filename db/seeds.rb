puts "🌱 Seeding users and todos..."

# Clear old data
Todo.delete_all
User.delete_all

users = [
  { email: "alice@example.com", password: "password" },
  { email: "bob@example.com", password: "password" },
  { email: "charlie@example.com", password: "password" }
]

users.each_with_index do |user_data, i|
  user = User.create!(user_data)

  5.times do |j|
    user.todos.create!(
      title: "Task #{j + 1} for #{user.email.split('@').first.capitalize}",
      description: "This is task #{j + 1} for #{user.email}",
      status: %w[pending in_progress done].sample
    )
  end
end

puts "✅ Seeded #{User.count} users and #{Todo.count} todos."
