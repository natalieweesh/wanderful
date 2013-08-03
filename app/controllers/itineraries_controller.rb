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
      
  end
  
end