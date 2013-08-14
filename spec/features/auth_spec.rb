require 'spec_helper'

feature "Sign up" do
  before :each do
    visit "/users/sign_up"
  end

  it "has a user sign up page" do
    page.should have_content "sign up"
  end

  it "takes a username, email, and password" do
    page.should have_content "username"
    page.should have_content "email"
    page.should have_content "password"
  end

  it "validates the presence of the user's login and password" do
    fill_in "user_username", with: 'hello_world'
    click_button 'sign up'
    page.should have_content 'sign up'
  end

  # it "validates that the password is at least 6 characters long" do
  #   fill_in "Username", with: 'hello_world'
  #   fill_in "Password", with: 'short'
  #   click_button 'Sign Up'
  #   page.should have_content 'Sign Up'
  # end

  it "logs the user in and redirects them to home page on success" do
    sign_up_as_hello_world
    # add user name to application.html.erb layout
    page.should have_button 'your profile'
  end
end

feature "sign out" do
  it "has a sign out button" do
    sign_up_as_hello_world
    page.should have_button 'sign-out-button'
  end

  it "logs a user out on click" do
    sign_up_as_hello_world

    click_button 'sign-out-button'
    visit '/'

    # redirect to login page
    page.should have_content 'sign in'
  end
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/users/sign_in"
    page.should have_content "sign in"
  end

  it "takes a login and password" do
    visit "/users/sign_in"
    page.should have_content "login"
    page.should have_content "password"
  end

  it "returns to sign in on failure" do
    visit "/users/sign_in"
    fill_in "user_login", with: 'hello_world'
    fill_in "user_password", with: 'hello'
    click_button "sign in"

    # return to sign-in page
    page.should have_content "sign in"
  end

  it "takes a user to posts index on success" do
    sign_up_as_hello_world
    # add button to sign out in application.html.erb layout
    click_button 'sign-out-button'

    # Sign in as newly created user
    visit "/users/sign_in"
    fill_in "user_login", with: 'hello_world'
    fill_in "user_password", with: 'abcdef'
    click_button "sign in"
    page.should have_button "your profile"
  end
end
