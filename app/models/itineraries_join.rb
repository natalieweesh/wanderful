class ItinerariesJoin < ActiveRecord::Base
  attr_accessible :activity_id, :itinerary_id
  
  belongs_to :activity
  belongs_to :itinerary
end
