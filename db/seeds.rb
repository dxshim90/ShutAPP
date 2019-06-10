# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Admin', nickname: 'admin', age: 30, email: 'admin@shutapp.com', password: 'password', password_confirmation: 'password', admin: true)
Group.create!(name: "ShutApp Community", owner_id: 1)
Member.create!(user_id: 1, group_id: 1)

# end
