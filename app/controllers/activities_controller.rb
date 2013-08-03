class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new(params[:activity])
    @tags = Tag.all
  end
  
  def create
    if params[:activity][:tag_ids].all?{|tag| tag==""}
      flash[:notice] = "must have at least one tag"
      redirect_to new_activity_url
    end
    
    @activity = Activity.new(params[:activity])
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
  
end