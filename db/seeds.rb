# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "guest admin",
             email: "a-guest@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "guest general",
             email: "g-guest@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)

97.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

99.times do |n|
  user_id = n+1
  50.times do |m|
  title = "task-#{m+1}"
  note = "note-#{m+1}"
  Task.create!(title: title,
               note: note,
               user_id: user_id)
  end
end