class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tags_joins
  has_many :activities, through: :tags_joins
  
  validates :name, presence: true, allow_blank: false
  validates_uniqueness_of :name

  def self.process_tags(arr)
    arr.map{|name| Tag.find_by_name(name).id }
  end
  
end
