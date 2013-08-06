class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @users = User.where('id != ?', current_user.id)
  end
  
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, @user.id)
    if @friendship.nil?
      @friendship_id = 0
    else
      @friendship_id = @friendship.id
    end
    
  end
  
end