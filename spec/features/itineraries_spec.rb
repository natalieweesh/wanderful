require 'spec_helper'

feature "Creating an itinerary" do
  
  context "when logged in", js: true do
    before :all do 
      sign_up_as_hello_world
    end
    before :each do
      sign_in("helloworld")
      # page.find('#share-something').trigger(:click)
      # click_button "add \n an \n itinerary"      
    end
   
    # it "has a new itinerary page" do
      # page.should have_content "add a new itinerary"
    # end
    
    it "creates a new activity when you fill in all the fields" do
      visit '/itineraries/new'
      fill_in "itin-description", with: 'test itinerary'
      
      save_and_open_page
      find('input[type=checkbox]').trigger(:click)

      # find_by_id('checkbox1')

      page.find('#new-itinerary-button').trigger(:click)
      
      page.should have_content 'test itinerary'
      
    end
    
  end
  
end