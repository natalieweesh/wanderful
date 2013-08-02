class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new
  end
  
  def create
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