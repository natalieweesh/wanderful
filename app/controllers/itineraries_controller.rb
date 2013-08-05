class ItinerariesController < ApplicationController
  
  def new
    @itinerary = Itinerary.new(params[:itinerary])
  end
  
  def create
    @itinerary = Itinerary.new(params[:itinerary])
    @itinerary.user_id = current_user.id
    if @itinerary.save
      redirect_to itinerary_url(@itinerary.id)
    else
      flash[:notice] = "error creating itinerary"
      render :new
    end
    
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @favorite = Favorite.find_by_user_id_and_itinerary_id(current_user.id, @itinerary.id)
    if @favorite.nil?
      @favorite_id = 0
    else
      @favorite_id = @favorite.id
    end
  end
  

  
end