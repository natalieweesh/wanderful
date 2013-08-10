class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new(params[:activity])
    @tags = Tag.all
    @tag_names = Tag.get_all_names
  end
  
  def create
    @tags = params[:activity][:tags].split(",")
    if @tags.empty?
      flash[:notice] = "please add at least one tag"
      redirect_to new_activity_url # render :new
      return
    end

    @tag_ids = Tag.process_tags(@tags)
    params[:activity][:tag_ids] = @tag_ids
    @activity = Activity.new(params[:activity].except("tags"))
    @activity.user_id = current_user.id
    if @activity.save
      redirect_to activity_url(@activity.id)
    else
      flash[:notice] = "error creating new activity"
      render :new
    end
    
  end
  
  def show
    @activity = Activity.find(params[:id])
  end

# the original search method :   
  # def search
  #   @tags_array = params[:search][:tags].split(",")
  #   @search_results = Activity.search(@tags_array, params[:search][:neighborhood])
  # end
  
  def search
    @tags_array = params[:search][:tags].split(",")
    
    # @results_by_location = Activity.near(params[:search][:address], 20) #20 mile radius
    @search_results = Activity.search(@tags_array, [params[:search][:latitude], params[:search][:longitude]], params[:search][:radius])
    # @search_results = @tags_array & @results_by_location #THIS ASSUMES THAT NEITHER IS BLANK, CAN WORK THAT OUT LATER
    
  end
  
  
end