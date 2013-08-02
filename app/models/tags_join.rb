class TagsJoin < ActiveRecord::Base
  attr_accessible :activity_id, :tag_id

  belongs_to :activity
  belongs_to :tag
end
