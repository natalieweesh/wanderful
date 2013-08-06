class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tags_joins
  has_many :activities, through: :tags_joins
  
  validates :name, presence: true, allow_blank: false
  validates_uniqueness_of :name

  def self.process_tags(arr)
    @ids = []
    arr.map do |name|
      tag = Tag.find_by_name(name)
      if tag.nil?
        @new_tag = Tag.create(name: name)
        @ids << @new_tag.id
      else
        @ids << tag.id
      end  
    end
    @ids
  end
  
  def self.get_all_names
    Tag.uniq.pluck(:name)
  end
  
end
