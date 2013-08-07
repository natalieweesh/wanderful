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
  
  # def self.search(params)
  def self.search(paramstags, paramsneighborhood)
    @activities_found = []
    p "PARAMS TAGS PARAMS TAGS PARAMS TAGS PARAMS TAGS PARAMS TAGS PARAMS TAGS "
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p paramstags
    p "PARAMS NEIGHBORHOOD PARAMS NEIGHBORHOOD PARAMS NEIGHBORHOOD PARAMS NEIGHBORHOOD "
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p paramsneighborhood
    # if !params["tags"].empty?
    if !paramstags.empty?
      tags = []
      # search_tags_ids = params["tags"].map{|str| str.to_i}
      # search_tags_ids = paramstags.map{|name| Tag.find_by_name(name).id }
      search_tags_ids = paramstags.map do |name|
        tag = Tag.find_by_name(name)
        if tag.nil?
          
        else
          tags << tag
        end
      end
      p "TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS TAGS "
      p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      p tags
      # @activities_found_by_tags = Activity.joins(:tags).where('tags.id IN (?)', search_tags_ids).group('activities.id').having('COUNT(*) >= ? ', params["tags"].length)
      @activities_found_by_tags = Activity.joins(:tags).where('tags.id IN (?)', tags).group('activities.id').having('COUNT(*) >= ? ', tags.length)
      p "ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS "
      p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      p @activities_found_by_tags
    else
      p "ACTIVITIES NOT FOUBD BY TAGS ACTIVITIES NOT FOUBD BY TAGS ACTIVITIES NOT FOUBD BY TAGS ACTIVITIES NOT FOUBD BY TAGS "
      @activities_found_by_tags = nil
    end

    # if params["neighborhood"] != "nil"
    if paramsneighborhood != ""
      # @activities_found_by_neighborhood = Activity.find_all_by_neighborhood(params["neighborhood"])
      @activities_found_by_neighborhood = Activity.find_all_by_neighborhood(paramsneighborhood)
    else
      @activities_found_by_neighborhood = nil
    end
    
    if @activities_found_by_tags.nil? && @activities_found_by_neighborhood.nil?
      @activities_found = []
    elsif !@activities_found_by_tags.nil? && @activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_tags
    elsif @activities_found_by_tags.nil? && !@activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_neighborhood
    else #if !@activities_found_by_tags.nil? && !@activities_found_by_neighborhood.nil?
      @activities_found = @activities_found_by_tags & @activities_found_by_neighborhood
    end

    @activities_found

  end
  
  def self.all_neighborhoods
    Activity.uniq.pluck(:neighborhood)
  end
  
end
