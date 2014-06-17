require 'spec_helper'

describe "sign process", type: :feature do
  it "should signs me in" do
    User.create! email: 'test@gmail.com', password: 'test'

    visit new_user_session_path
    
    within("form") do
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: 'test'
    end
    
    click_button 'Sign in'
    page.should have_content 'Signed in successfully'
  end

  it "should signs me up" do
    visit new_user_registration_path
    
    within("form") do
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_password', with: 'test'
      fill_in 'user_password_confirmation', with: 'test'
    end
    
    click_button 'Sign up'
    page.should have_content 'Welcome! You have signed up successfully.'
  end
end