class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id
  
  belongs_to :friend, class_name: "User", primary_key: :id
  belongs_to :user
  
  validates_uniqueness_of :user_id, scope: [:friend_id, :user_id]
  
end
