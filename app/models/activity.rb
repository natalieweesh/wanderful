class Activity < ActiveRecord::Base
  attr_accessible :description, :neighborhood, :user_id, :venue, :tag_ids, :latitude, :longitude, :address, :activity_photo
  
  has_attached_file :activity_photo, :styles => {
    :big => "400x400>",
    :medium => "190x190#",
    :small => "50x50#"
  }
  
  before_create :randomize_file_name
  
  validates :description, :venue, presence: true
  # validate :at_least_one_tag
  # validates_associated :tags_joins, presence: true, allow_blank: false
  validates_associated :tags, presence: true, allow_blank: false

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates



  belongs_to :user
  
  has_many :tags_joins
  has_many :tags, through: :tags_joins
  
  has_many :itineraries_joins
  has_many :itineraries, through: :itineraries_joins
  

  has_many :comments
    
  def comments_by_parent
    hash = Hash.new([])
    comments.each do |comment|
      hash[comment.parent_comment_id] += [comment]
    end
    hash
  end
  

  private
  
  def randomize_file_name
    extension = File.extname(activity_photo_file_name).downcase
    self.activity_photo.instance_write(:file_name, "#{SecureRandom.urlsafe_base64(16)}#{extension}")
  end
  
  # def at_least_one_tag
    # errors.add(:tags, "must have at least one tag") unless self.tag_ids.length > 1  
  # end
  
  # def self.search(params)

  
  
  
  
  
  
  
  
  
  
  # "REFACTORED" CODE BELOW
  def self.search(paramstags, paramslatlong, paramsradius)
    @activities_found = []
    if !paramstags.empty? # if any tags are given
      tags = []
      search_tags_ids = paramstags.map do |name|
        tags << Tag.find_by_name(name) # (none of the tags should be nil now that we're using select2)
      end
      @activities_found_by_tags = Activity.joins(:tags).where('tags.id IN (?)', tags).group('activities.id').having('COUNT(*) >= ? ', tags.length) # MAKE SURE POSTGRESQL IS OKAY WITH THIS QUERY!!!!!!!
    else
      @activities_found_by_tags = nil
    end
    p "ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS ACTIVITIES FOUND BY TAGS "
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p @activities_found_by_tags
    # if paramsneighborhood != ""
      # @activities_found_by_neighborhood = Activity.find_all_by_neighborhood(paramsneighborhood)
    # else
      # @activities_found_by_neighborhood = nil
    # end
    p "PARAMS LATLONG PARAMS LATLONG PARAMS LATLONG PARAMS LATLONG PARAMS LATLONG PARAMS LATLONG "
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p paramslatlong
    
    p "PARAMS RADIUS PARAMS RADIUS PARAMS RADIUS PARAMS RADIUS PARAMS RADIUS PARAMS RADIUS PARAMS RADIUS "
    p paramsradius
    
    @activities_found_by_location = Activity.near(paramslatlong, paramsradius.to_i)
    
    p "ACTIVITIES NEAR PARAMSADDRESS ACTIVITIES NEAR PARAMSADDRESS ACTIVITIES NEAR PARAMSADDRESS"
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p @activities_found_by_location
    
    if @activities_found_by_tags.nil? && @activities_found_by_location.empty?
      @activities_found = []
    elsif !@activities_found_by_tags.nil? && @activities_found_by_location.empty?
      @activities_found = @activities_found_by_tags
    elsif @activities_found_by_tags.nil? && !@activities_found_by_location.empty?
      @activities_found = @activities_found_by_location
    else #if !@activities_found_by_tags.nil? && !@activities_found_by_location.nil?
      @activities_found = @activities_found_by_tags & @activities_found_by_location
    end

    @activities_found

  end
  
  
  def self.filter_by_tags(tag_ids) # array of tag_ids, e.g. [8, 9]
    result = []
    
    Activity.all.each do |activity|
      if !(activity.tag_ids & tag_ids).empty?
        result << activity
      end
    end
    
    result = result.uniq
    result.map{ |activity| activity.id } #return the activity ids that include any of these tags

  end
  
  
  
  
  
  # def self.all_neighborhoods
  #   Activity.uniq.pluck(:neighborhood)
  # end


  # def self.sort_by_tags
  #   
  # end
  
  
  
end
