require 'spec_helper'

describe "ideas/index" do
  include Devise::TestHelpers

  before :each do
    @current_user = User.create! email: 'current@gmail.com', password: 'test'
    @other_user   = User.create! email: 'other@gmail.com', password: 'test'

    @current_user_ideas = [
      stub_model(Idea, content: 'content_idea1', user: @current_user), 
      stub_model(Idea, content: 'content_idea2', user: @current_user)
    ]

    @ideas = @current_user_ideas + [
      stub_model(Idea, content: 'content_idea3', user: @other_user)
    ]
  end

  describe "with authentication" do
    before :each do 
      sign_in @current_user
    end

    it "must to list current_user ideas with edit & delete options" do
      assign(:ideas, @current_user_ideas)
      render
      expect(view).to render_template("index")
      
      expect(rendered).to include 'content_idea1'
      expect(rendered).to include 'content_idea2'
      
      expect(rendered).to match /a href=["']\/ideas\/#{@current_user_ideas.first.id}["'].+?data-method=["']delete/
      expect(rendered).to match /a href=["']\/ideas\/#{@current_user_ideas.first.id}\/edit["']/
      expect(rendered).to match /a href=["']\/ideas\/#{@current_user_ideas.last.id}["'].+?data-method=["']delete/
      expect(rendered).to match /a href=["']\/ideas\/#{@current_user_ideas.last.id}\/edit["']/
    end

  end

  describe "without authentication" do
    it "must to show all ideas without edition options" do
      render
      expect(view).to render_template("index")
      
      expect(rendered).to include 'content_idea1'
      expect(rendered).to include 'content_idea2'
      expect(rendered).to include 'content_idea3'

      expect(rendered).not_to match /a href=["']\/ideas\/\d+["'].+?data-method=["']delete/
      expect(rendered).not_to match /a href=["']\/ideas\/\d+\/edit["']/
    end
  end
end

