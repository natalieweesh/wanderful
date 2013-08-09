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
  
  def search
    #if no time given and activitiessearchterms given
    #if activitiessearchterms is blank, return no results
    # else return all itineraries including those activities
    #if time given and no activitessearchterms given
    # if no itineraries with that time span, return nothing
    # else return those itineraries with times given
    p "ALL THE PARAMS ALL THE PARAMS ALL THE PARAMS ALL THE PARAMS ALL THE PARAMS ALL THE PARAMS ALL THE PARAMS"
    p params[:search]
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    
    @tags_array = params[:search][:activity][:search][:tags].split(",")
    
    
    # @activities_search_result = Activity.search(@tags_array, params[:search][:activity][:search][:neighborhood])
    # FOR NOW, JUST SEARCH BY ACTIVITY TAGS, NOT LOCATION
    @activities_search_result = Activity.search(@tags_array, [params[:search][:activity][:search][:latitude], params[:search][:activity][:search][:longitude]], params[:search][:activity][:search][:radius])
    # @activities_search_result = Activity.search(@tags_array, "", "")
    
    p "ACTIVITIES SEARCH RESULT ACTIVITIES SEARCH RESULT ACTIVITIES SEARCH RESULT ACTIVITIES SEARCH RESULT"
    p @activities_search_result
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    if params[:search][:itinerary][:time] == ""
      if @activities_search_result.nil? || @activities_search_result.empty?
        @search_results = []
        p "SEARCH RESULTS ARE EMPTY SEARCH RESULTS ARE EMPTY SEARCH RESULTS ARE EMPTY SEARCH RESULTS ARE EMPTY"
        p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      else
        @search_results = Itinerary.finer_search(@activities_search_result.map{|act| act.id})
        p "DID FINER SEARCH DID FINER SEARCH DID FINER SEARCH DID FINER SEARCH DID FINER SEARCH"
        p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        p @search_results
      end
    elsif params[:search][:itinerary][:time] != ""
      if @activities_search_result.nil? || @activities_search_result.empty?
        @search_results = Itinerary.search(params[:search][:itinerary])
        p "TIME GIVEN AND ACTIVITIES RESULT IS NILLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
        p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      else
        p "TIME GIVEN AND ACTIVITIES RESULT IS NOT NILLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
        p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        p "PARAMS[:SEARCH][:ITINERARY] PARAMS[:SEARCH][:ITINERARY] PARAMS[:SEARCH][:ITINERARY] PARAMS[:SEARCH][:ITINERARY]"
        p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        p params[:search][:itinerary]
        @time_result = Itinerary.search(params[:search][:itinerary])
        p "TIME RESULT TIME RESULT TIME RESULT TIME RESULT TIME RESULT TIME RESULT TIME RESULT "
        p @time_result
        @search_results = @time_result & Itinerary.finer_search(@activities_search_result.map{|act| act.id})
      end
    end
  
    @search_results
    
  end
  
  def index
    
    top_ten_favs = Favorite.select('favorites.itinerary_id').group('favorites.itinerary_id').order('COUNT(favorites.id) DESC').limit(10)
    
    @top_ten = top_ten_favs.map{ |fav| fav.itinerary }
    
  end

  
end