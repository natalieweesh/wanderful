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



Activity.create(description: "try new food stands", venue: "smorgasburg", neighborhood: "williamsburg")
Activity.create(description: "play carnival games at luna park", venue: "coney island", neighborhood: "brooklyn")
Activity.create(description: "have an expertly brewed cup of coffee", venue: "stumptown coffee roasters, 8th street", neighborhood: "greenwich village")
Activity.create(description: "grab some gelato", venue: "l'arte del gelato (chelsea market)", neighborhood: "chelsea")
Activity.create(description: "go kayaking", venue: "hudson river", neighborhood: "west side")
Activity.create(description: "take a trapeze class", venue: "chelsea piers", neighborhood: "chelsea")
Activity.create(description: "go to a free concert", venue: "prospect park bandshell", neighborhood: "park slope")
Activity.create(description: "play guitar in central park", venue: "central park", neighborhood: "central park")

Itinerary.create(description: "an adventurous day", time_it_takes: 5, user_id: 1)
ItinerariesJoin.create(itinerary_id: 2, activity_id: 3)
ItinerariesJoin.create(itinerary_id: 2, activity_id: 7)
ItinerariesJoin.create(itinerary_id: 2, activity_id: 8)

Itinerary.create(description: "a cheap day out", time_it_takes: 4, user_id: 1)
ItinerariesJoin.create(itinerary_id: 3, activity_id: 9)
ItinerariesJoin.create(itinerary_id: 3, activity_id: 10)

Itinerary.create(description: "", time_it_takes: , user_id: )

Activity.create(description: "", venue: "", neighborhood: "")
