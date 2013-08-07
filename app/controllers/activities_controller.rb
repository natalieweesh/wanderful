class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new(params[:activity])
    @tags = Tag.all
    @tag_names = Tag.get_all_names
  end
  
  def create
    p "PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS PARAMS"
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    p params[:activity][:tags]
    @tags = params[:activity][:tags].split(",")
    if @tags.empty?
      flash[:notice] = "must have at least one tag"
      render :new
      return
    end
    
    # if params[:activity][:tag_ids].all?{|tag| tag==""}
    #   flash[:notice] = "must have at least one tag"
    #   render :new
    # end
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
  
  # def search    
  #   @search_results = Activity.search(params[:search])
  # end
  
  def search
    
    @tags_array = params[:search][:tags].split(" #")
    p "@TAGS_ARRAY @TAGS_ARRAY @TAGS_ARRAY @TAGS_ARRAY @TAGS_ARRAY @TAGS_ARRAY @TAGS_ARRAY "
    p @tags_array
    p "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    @search_results = Activity.search(@tags_array, params[:search][:neighborhood])
  end
  
  
end