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
    p "ALL PARAMS"
    p params
    @activities_found = []
    p "WHITTELED TAGS"
    p params["tags"].delete("")
    if !params["tags"].empty?
      p "PARAMS TAGS"
      p params["tags"]
      search_tags_ids = params["tags"].map{|str| str.to_i}
      @activities_found_by_tags = Activity.joins(:tags).where('tags.id IN (?)', search_tags_ids).group('activities.id').having('COUNT(*) >= ? ', search_tags_ids.length)
      p "ACTIVITIES FOUND BY TAGS"
      p @activities_found_by_tags
    end
    if !params["neighborhood"].empty?
      p "PARAMS NEIGHTBORHOOD"
      p params["neighborhood"]
      @activities_found_by_neighborhood = Activity.find_all_by_neighborhood(params["neighborhood"])
    end
    
    if !@activities_found_by_tags.empty? && @activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_tags
    elsif @activities_found_by_tags.empty? && !@activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_neighborhood
    elsif @activities_found_by_tags.empty? && @activities_found_by_neighborhood.nil?
      @activities_found = []
    elsif !@activities_found_by_tags.empty? && !@activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_tags & @activities_found_by_neighborhood
    end
    
    
    p "DONEEEEEEEEEEEEEEE"
    @activities_found

  end
  
  def self.all_neighborhoods
    Activity.uniq.pluck(:neighborhood)
  end
  
end
