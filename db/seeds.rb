require 'faker'

5.times do
  User.create!(
    username: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: 'helloworld',
    role: 'standard',
    confirmed_at: Time.now
  )
end
User.create!(
  username: 'admin',
  email: 'admin@admin.com',
  password: 'helloworld',
  role: 'admin',
  confirmed_at: Time.now
)
User.create!(
  username: 'Bob',
  email: 'bob@dabuilder.com', 
  password: 'helloworld',
  role: 'standard',
  confirmed_at: Time.now
)
User.create!(
  username: 'Jack',
  email: 'jack@standard.com',
  password: 'helloworld',
  role: 'standard',
  confirmed_at: Time.now
)
users = User.all

# Create wikis
20.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Vehicle.unique.manufacture,
    body: Faker::Vehicle.unique.vin
  )
end
wikis = Wiki.all

puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
