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
    
    
    @activities_search_result = Activity.search(@tags_array, params[:search][:activity][:search][:neighborhood])
    
    p "PARAMS[:SEARCH][:ACTIVITY] PARAMS[:SEARCH][:ACTIVITY] PARAMS[:SEARCH][:ACTIVITY] PARAMS[:SEARCH][:ACTIVITY]"
    p params[:search][:activity]
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
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

    # @activities_search_result = Activity.search(params[:search][:activity])
#     @itineraries_by_time = Itinerary.search(params[:search][:itinerary])
#     if (@activities_search_result.nil? || @activities_search_result.empty?) && 
#                                 (@itineraries_by_time.nil? || @itineraries_by_time.empty?)
#       @search_results = []
#     elsif (@activities_search_result.nil? || @activities_search_result.empty?) && 
#     if params[:search][:itinerary][:time] == "" #no time-it-takes was given
#       if @activities_search_result.nil? || @activities_search_result.empty?
#         @search_results = []
#       else
#         @search_results = @activities_search_result
#       end
#     else
#       if @activities_search_result.nil? || @activites_search_result.empty?
#         @search_results = @itineraries_by_time
#       else
#         
#         @search_results = @itineraries_by_time & @activities_search_result
#       end
#     end
  
    @search_results
    
  end
  

  
end