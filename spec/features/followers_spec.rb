require 'spec_helper'

feature "Following another user" do
  
  context "when logged in", js: true do
    
    before :each do
      sign_in("helloworld")
    end
    
    it "works!" do
      visit '/users/1'
      click_button 'follow'
      page.should have_button 'unfollow'
      click_button 'unfollow' #so this test works the next time too
    end

    
  end
  
end