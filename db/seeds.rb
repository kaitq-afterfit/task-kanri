Faker::Config.locale = :ja

User.create!(name:  "Administration",
             email: "admin@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             is_admin: true)

10.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@test.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

4.times do
  name = Faker::Lorem.sentence(word_count: 2)
  description = Faker::Lorem.sentence(word_count: 6)
  Label.create!(name: name, description: description)
end

# Creating 9 tasks owned by 3 earliest user
owners = User.order(:created_at).take(3)
owners.each do |user|
  name = Faker::Lorem.sentence(word_count: 3)
  description = Faker::Lorem.sentence(word_count: 6)
  user.tasks.create!(name: name, start_date: 1.week.ago, due_date: 3.days.ago, description: description, status: 3)
  name = Faker::Lorem.sentence(word_count: 2)
  description = Faker::Lorem.sentence(word_count: 9)
  user.tasks.create!(name: name, start_date: 4.days.ago, due_date: 2.days.since.to_date, description: description, status: 2)
  name = Faker::Lorem.sentence(word_count: 1)
  description = Faker::Lorem.sentence(word_count: 12)
  user.tasks.create!(name: name, start_date: 3.days.ago, due_date: 3.days.since.to_date, description: description, status: 1)
end
# Assigning all tasks to first 5 alphabelt non-admin users
users = User.where(is_admin: false).order(:name).take(5)
tasks = Task.all
tasks.each do |task|
  users.each do |user|
    task.assignees << user
  end
end
# Assigning labels to tasks
labels = Label.all
labels.each do |label|
  task = Task.find(label.id % 3 + 1)
  label.tasks << task
  label.tasks << Task.find(6)
end
