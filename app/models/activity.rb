class Activity < ActiveRecord::Base
  attr_accessible :description, :neighborhood, :user_id, :venue
  
  belongs_to :user
  
  has_many :tags_joins
  has_many :tags, through: :tags_joins
  
end
