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

<<<<<<< HEAD
=======
Favorite.create(user: bernard,
                price: 325000,
                rendement: 3.45,
                rooms: 2,
                surface: 55,
                urlscrap: 'https://www.leboncoin.fr/ventes_immobilieres/1511562371.htm/',
                urlimage: 'https://img0.leboncoin.fr/ad-image/e04eda6d3c71c8b4a0e764e7b2d9dca7a877fe85.jpg')
>>>>>>> 6d96cd4d9830d4489fcd14051af92aebee44a810

puts "#{User.all.count} users !"
puts "#{Favorite.all.count} favorites !"
