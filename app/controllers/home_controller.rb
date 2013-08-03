class HomeController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  def index
    @random_id = rand(Itinerary.all.count) + 1;
  end
end