# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bernard = User.create(email: 'bernard@gmail.com', password: 'azerty')

Favorite.create(user: bernard,
                price: 85000,
                rendement: 2.45,
                rooms: 1,
                surface: 11,
                urlscrap: 'https://www.leboncoin.fr/vi/1531634442.htm/',
                urlimage: 'https://img3.leboncoin.fr/ad-image/dd0992acc2f5b632d8a15ca5a5c37be7e085969c.jpg')


puts "#{User.all.count} users !"
puts "#{Favorite.all.count} favorites !"
