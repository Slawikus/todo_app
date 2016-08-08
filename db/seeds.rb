# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(username: "User1", password: "password")
user1.tasks.create([{title: "U1 task1"}, {title: "U1 task2"}, {title: "U1 task3"}])

user2 = User.create(username: "User2", password: "password")
user2.tasks.create([{title: "U2 task1"}, {title: "U2 task2"}, {title: "U2 task3"}])

user3 = User.create(username: "User3", password: "password")
user3.tasks.create([{title: "U3 task1"}, {title: "U3 task2"}, {title: "U3 task3"}])
