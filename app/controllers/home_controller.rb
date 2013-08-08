class HomeController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  def index
    @tag_names = Tag.get_all_names
  end
end