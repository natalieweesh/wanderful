class FriendshipsController < ApplicationController
  
  def create
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:friendship][:friend_id])
    respond_to do |format|
      format.json { render :json => @friendship }
    end
  end
  
  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    respond_to do |format|
      format.json { render :json => "destroyed!".to_json }
    end
  end
  
  
  
end