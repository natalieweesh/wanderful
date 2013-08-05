class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(user_id: current_user.id, itinerary_id: params[:favorite][:itinerary_id])
    respond_to do |format|
      format.json { render :json => @favorite }
    end
  end
  
  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    respond_to do |format|
      format.json { render :json => "destroyed!".to_json }
    end
  end

end