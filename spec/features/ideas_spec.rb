require 'spec_helper'

describe "Ideas management", type: :feature do
  include Warden::Test::Helpers
  Warden.test_mode!
  
  before(:all) do
    Capybara.current_driver = :selenium
  end
  
  after(:all) do
    Capybara.use_default_driver
  end  
  before :each do
    user  = User.create email: 'test@gmail.com', password: 'test'
    @idea = Idea.new content: 'edit me'
    
    @idea.user = user
    @idea.save
    @current_ability = Ability.new user
    
    login_as user, :scope => :user
  end

  after :each do
    Warden.test_reset!
  end

  it "should redirect to idea edition page" do
    visit ideas_path
    page.find('a.action-edit').click
    page.should have_content @idea.content
  end
  
  it "should show an alert to confirm deletion", :js => true, :driver => :webkit do
    visit ideas_path
    page.find('a.action-destroy').click
    #sleep 3 
    page.driver.confirm_messages.should have_content 'Are you sure?'
  end
end