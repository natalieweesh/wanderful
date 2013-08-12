class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login, :favorite_itinerary_ids, :friend_ids, :provider, :uid
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
         
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]       
  devise :omniauthable, :omniauth_providers => [:facebook]
  # devise :confirmable
  
  validates :username, :uniqueness => { :case_sensitive => false }
  # validates :username, presence: true
  
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
  
  def self.find_or_create_by_facebook_oauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create!(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      username: auth.info.name,
      password: Devise.friendly_token[0,20]
    )
    end

    user
  end
  
end
