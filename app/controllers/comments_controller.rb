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
  
  
end