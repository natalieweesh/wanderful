class Itinerary < ActiveRecord::Base
  attr_accessible :description, :time_it_takes, :user_id, :activity_ids
  
  belongs_to :user
  
  has_many :itineraries_joins
  has_many :activities, through: :itineraries_joins
end
