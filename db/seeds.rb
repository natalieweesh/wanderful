# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Activity.create(description:"go to the zoo", venue:"bronx zoo", neighborhood: "bronx")
Activity.create(description:"get a haircut", venue:"barbershop", neighborhood:"chinatown")
Itinerary.create(description:"a productive day", time_it_takes: 3, user_id: 1)
ItinerariesJoin.create(itinerary_id: 1, activity_id: 1)
ItinerariesJoin.create(itinerary_id: 1, activity_id: 2)
