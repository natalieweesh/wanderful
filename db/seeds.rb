# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.new(username:"apple", email:"apple@gmail.com", password:"password")
a.save
b = User.new(username:"banana", email:"banana@gmail.com", password:"password")
b.save
c = User.new(username:"carrot", email:"carrot@gmail.com", password:"password")
c.save
d = User.new(username:"durian", email:"durian@gmail.com", password:"password")
d.save
e = User.new(username:"elderberry", email:"elderberry@gmail.com", password:"password")
e.save

Tag.create([{name: "indoors"}, {name: "outdoors"}, {name: "wild"}, {name: "old school"}, {name: "educational"}, {name: "hilarious"}, {name: "musical"}, {name: "divey"}, {name: "beautiful"}, {name: "walking"}, {name: "foodie"}, {name: "cheap"}, {name: "early morning"}, {name: "shopping"}, {name: "active"}])

a1 = Activity.create(description: "roller disco", venue: "riverbank state park", neighborhood: nil, user_id: 1, latitude: 40.826817, longitude: -73.951653, address: "W 145 St - Riverside Dr, New York, NY 10031, USA")
a1.tag_ids = [1, 3, 4]
a2 = Activity.create(description: "people watching", venue: "washington square park", neighborhood: nil, user_id: 2, latitude: 40.7250632, longitude: -73.9976946, address: "New York, NY 10012, USA")
a2.tag_ids = [1, 5, 6]
a3 = Activity.create(description: "attend an open mic", venue: "pete's candy store", neighborhood: nil, user_id: 3, latitude: 40.6470923, longitude: -73.9536163, address: "Brooklyn, NY 11226, USA")
a3.tag_ids = [1, 8, 7]
a4 = Activity.create(description: "$5 comedy show", venue: "upright citizens brigade", neighborhood: nil, user_id: 4, latitude: 40.75368539999999, longitude: -73.9991637, address: "New York, NY 10001, USA")
a4.tag_ids = [1, 6]
a5 = Activity.create(description: "walk along the highline", venue: "the high line", neighborhood: nil, user_id: 5, latitude: 40.747425, longitude: -74.003761, address: "W 23 St - 10 Av, New York, NY 10011, USA")
a5.tag_ids = [2, 9, 10]
a6 = Activity.create(description: "try new food stands", venue: "smorgasburg", neighborhood: nil, user_id: 1, latitude: 40.7119031, longitude: -73.9660683, address: "Brooklyn, NY 11249, USA")
a6.tag_ids = [2, 11, 12]
a7 = Activity.create(description: "wake up really early to queue for cronuts", venue: "dominique ansel bakery", neighborhood: nil, user_id: 2, latitude: 40.723384, longitude: -74.001704, address: "SoHo, New York, NY, USA")
a7.tag_ids = [11, 13]
a8 = Activity.create(description: "watch an indie film", venue: "IFC center", neighborhood: nil, user_id: 3, latitude: 40.730881, longitude: -74.001389, address: "Av of the Americas - W 3 St, New York, NY 10012, USA")
a8.tag_ids = [1, 5, 6, 9]
a9 = Activity.create(description: "vintage clothes shopping", venue: "east 23rd street", neighborhood: nil, user_id: 4, latitude: 40.738995, longitude: -73.983276, address: "E 23 St / 3 Av, New York, NY 10010, USA")
a9.tag_ids = [4, 10, 12, 14]
a10 = Activity.create(description: "biking in central park", venue: "central park", neighborhood: nil, user_id: 5, latitude: 40.7711329, longitude: -73.97418739999999, address: "Central Park, New York, NY, USA")
a10.tag_ids = [2, 9, 12, 15]

i1 = Itinerary.create(description: "a cheap day out", time_it_takes: 5, user_id: 1)
i1.activity_ids = [2, 4, 5, 6]
i2 = Itinerary.create(description: "a mellow day", time_it_takes: 3, user_id: 2)
i2.activity_ids = [2, 3, 8]
i3 = Itinerary.create(description: "throwback thursday", time_it_takes: 4, user_id: 3)
i3.activity_ids = [1, 3, 9, 10]
i4 = Itinerary.create(description: "foodie tour", time_it_takes: 2, user_id: 4)
i4.activity_ids = [6, 7]
i5 = Itinerary.create(description: "for morning people", time_it_takes: 1, user_id: 5)
i5.activity_ids = [5, 7]
i6 = Itinerary.create(description: "when you're feeling restless", time_it_takes: 4, user_id: 1)
i6.activity_ids = [1, 5, 10]
i7 = Itinerary.create(description: "a cheap night out", time_it_takes: 2, user_id: 2)
i7.activity_ids = [3, 4]

Friendship.create(user_id: 1, friend_id: 2)
Friendship.create(user_id: 1, friend_id: 3)
Friendship.create(user_id: 1, friend_id: 4)
Friendship.create(user_id: 2, friend_id: 1)
Friendship.create(user_id: 2, friend_id: 3)
Friendship.create(user_id: 3, friend_id: 5)
Friendship.create(user_id: 4, friend_id: 2)
Friendship.create(user_id: 4, friend_id: 5)
Friendship.create(user_id: 5, friend_id: 1)
Friendship.create(user_id: 5, friend_id: 2)

Favorite.create(user_id: 1, itinerary_id: 1)
Favorite.create(user_id: 2, itinerary_id: 3)
Favorite.create(user_id: 3, itinerary_id: 6)
Favorite.create(user_id: 4, itinerary_id: 5)
Favorite.create(user_id: 5, itinerary_id: 4)

