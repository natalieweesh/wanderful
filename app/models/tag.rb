class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tags_joins
  has_many :activities, through: :tags_joins
end
