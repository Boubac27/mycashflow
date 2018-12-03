# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

boubacar = User.create(email: 'boubacar@gmail.com', password: 'azerty')

Favorite.create(user: boubacar,
                price: 142000,
                rendement: 8.02,
                rooms: 3,
                surface: 64,
                urlscrap: 'https://www.leboncoin.fr/ventes_immobilieres/1532112317.htm/',
                urlimage: 'https://img5.leboncoin.fr/ad-image/76bb00fa15f2be3ec6b385a8e8b55690745b6ff3.jpg',
                lat: 44.372,,
                long: 4.64441)


Favorite.create(user: boubacar,
                price: 239000,
                rendement: 6.40,
                rooms: 3,
                surface: 79,
                urlscrap: 'https://www.leboncoin.fr/ventes_immobilieres/1532077853.htm/',
                urlimage: 'https://img4.leboncoin.fr/ad-image/101aaf8e242d53ba8bbfd3a186f7c538dedbd71c.jpg'
                lat: 45.8127166804,
                long: 5.8446052441))

puts "#{User.all.count} users !"
puts "#{Favorite.all.count} favorites !"
