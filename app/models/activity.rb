class Activity < ActiveRecord::Base
  attr_accessible :description, :neighborhood, :user_id, :venue, :tag_ids

  belongs_to :user
  
  has_many :tags_joins
  has_many :tags, through: :tags_joins
  
  has_many :itineraries_joins
  has_many :itineraries, through: :itineraries_joins
  
  validates :description, :neighborhood, :venue, presence: true
  # validate :at_least_one_tag
  # validates_associated :tags_joins, presence: true, allow_blank: false
  validates_associated :tags, presence: true, allow_blank: false
  private
  
  # def at_least_one_tag
    # errors.add(:tags, "must have at least one tag") unless self.tag_ids.length > 1  
  # end
  
  def self.search(params)
    @activities_found = []
    if params["tags"]
      search_tags_ids = params["tags"].map{|str| str.to_i}
      p "TAGS_IDS"
      p search_tags_ids

      @activities_found += Activity.joins(:tags).where('tags.id IN (?)', search_tags_ids).group('activities.id').having('COUNT(*) >= ? ', search_tags_ids.length)
        


      
    end
    p "ACTIVITES FOUND!"
    p @activities_found
    p "DONEEEEEEEEEEEEEEE"
    @activities_found

  end
  
end
