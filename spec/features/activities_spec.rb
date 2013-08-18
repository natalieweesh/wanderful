require 'spec_helper'

feature "Creating an activity" do
  
  context "when logged in", js: true do
    
    before :each do
      sign_in("helloworld")
      page.find('#share-something').trigger(:click)
      click_button "add \n an \n activity"      
    end
    
    it "has a new activity page" do
      # sign_up_as_hello_world
      # visit '/'
      # click_link "share-something"
      # (find '#share-something').click
      # click_button 'share <br> something <br> to <br> do'

      # page.execute_script("$('#share-something').trigger('click')")

      page.should have_content "add a new activity"
    end
    
    it "does not create a new activity if you do not fill in all the fields" do
      fill_in "activity_description", with: 'test activity'
      fill_in "activity_venue", with: 'test activity venue'
      fill_in "address", with: '770 broadway, new york'
      page.find('.pin-button').trigger(:click)
      page.execute_script "$('#s2id_autogen1').val('indoors')"
      page.execute_script "$('#s2id_autogen1').trigger('keypress', [9])"
      # fill_in "s2id_autogen1", with: "indoors"
      # select2('indoors', from: "tags")
      # select2('indoors', from: "tags")

      save_and_open_page
      page.find('#new-activity-button').trigger(:click)
      page.should have_content "add a new activity"
    end
    
  end
  
end