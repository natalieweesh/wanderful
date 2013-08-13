class CommentsController < ApplicationController
  def create
    
    @comment = Comment.new(params[:comment])
    @comment.save
    
    if request.xhr?
      # Render a partial as response when using ajax requests.
      render @comment
    else
      # Redirect as usual for plain html requests.
      redirect_to comments_url
    end
    
    
  end
  
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @activity_id = @comment.activity_id
    if @comment.child_comments.empty?
      @comment.destroy
    else
      @comment.body = "This comment has been deleted."
      @comment.save
    end
    
    if request.xhr?
      p "STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF STUFFF"
      if @comment.child_comments.empty?
        render json: "Hahaha.".to_json 
      else
        render json: "This comment has been deleted.".to_json

      end
    else
      redirect_to activity_url(@activity_id)
    end

  end
  
  
end