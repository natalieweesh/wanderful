class Favorite < ActiveRecord::Base
  attr_accessible :itinerary_id, :user_id
  belongs_to :itinerary
  belongs_to :user
end
