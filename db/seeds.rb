# User.create!(name:  "Administration",
#              email: "admin@example.com",
#              password:              "adminuser",
#              password_confirmation: "adminuser",
#              is_admin: true)

# Label.create!(name: "bug",
#               description: "Bugs appeared when developing.")
# Label.create!(name: "enhancement",
#               description: "Make functions work better.")
# Label.create!(name: "design",
#               description: "Making designs and related documents.")

# 10.times do |n|
#   name  = Faker::Name.name
#   email = "member-#{n+1}@example.com"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password)
# end

# Creating 6 tasks owned by 3 earliest user
creators = User.order(:created_at).take(3)
creators.each do |user|
  name = "TASK_" + Faker::Lorem.sentence(word_count: 2)
  description = Faker::Lorem.sentence(word_count: 6)
  user.tasks.create!(name: name, start_date: 1.week.ago, due_date: 2.days.ago, description: description, status: 3)
  name = "TASK_" + Faker::Lorem.sentence(word_count: 2)
  description = Faker::Lorem.sentence(word_count: 6)
  user.tasks.create!(name: name, start_date: 6.days.ago, due_date: 1.day.ago, description: description, status: 2)
end
# Assigning all tasks to first 5 alphabelt users
users = User.order(:name).take(5)
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
