Search.destroy_all
Favorite.destroy_all
User.destroy_all

boubacar = User.create(email: 'ba.boubacar27@gmail.com', password: 'azerty')
Search.create(
  user: boubacar,
  budget: 300000,
  city: 'Lyon',
  zipcode: 69003,
  last_scrap: 2.days.ago
)
Search.create(
  user: boubacar,
  budget: 250000,
  city: 'Dardilly',
  zipcode: 69570,
  last_scrap: 4.days.ago
)

puts "#{User.all.count} users !"
puts "#{Favorite.all.count} favorites !"
