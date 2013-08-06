class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login, :favorite_itinerary_ids, :friend_ids
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
         
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]       
         
  # attr_accessible :title, :body
  validates :username, :uniqueness => { :case_sensitive => false }
  
  has_many :activities
  has_many :itineraries
  
  has_many :favorites
  has_many :favorite_itineraries, through: :favorites, source: :itinerary
  
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
end
