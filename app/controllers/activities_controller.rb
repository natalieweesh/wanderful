class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new(params[:activity])
    @tags = Tag.all
    @tag_names = Tag.get_all_names
  end
  def edit
    @activity = Activity.find(params[:id])
    @tags = Tag.all
    @tag_names = Tag.get_all_names
  end
  def update
    @activity = Activity.find(params[:id])
    
    @tags = params[:activity][:tags].split(",")
    if @tags.empty?
      flash[:notice] = "please fill in all fields"
      redirect_to new_activity_url # render :new
      return
    end

    @tag_ids = Tag.process_tags(@tags)
    params[:activity][:tag_ids] = @tag_ids
    @activity.update_attributes(params[:activity].except("tags"))
    
    
    redirect_to activity_url(@activity.id)
  end
  def create
    @tags = params[:activity][:tags].split(",")
    if @tags.empty?
      flash[:notice] = "please fill in all fields"
      redirect_to new_activity_url # render :new
      return
    end

    @tag_ids = Tag.process_tags(@tags)
    params[:activity][:tag_ids] = @tag_ids
    @activity = Activity.new(params[:activity].except("tags"))
    @activity.user_id = current_user.id
    @activity.save

    if request.xhr?
      # Render a partial as response when using ajax requests.
      render partial: "itineraries/checkboxes", locals: {activity: @activity}
    else
      # Redirect as usual for plain html requests.
      redirect_to activity_url(@activity.id)
    end
    
  end
  
  def show
    @activity = Activity.find(params[:id])
  end

  def search
    @tags_array = params[:search][:tags].split(",")
    
    @search_results = Activity.search(@tags_array, [params[:search][:latitude], params[:search][:longitude]], params[:search][:radius])
  
    #recommend 5 random activities if search comes up empty
    @backup_results = Activity.select('activities.*').order('RANDOM()').limit(5)
    
  end
  
  
end