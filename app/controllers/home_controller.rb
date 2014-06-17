class HomeController < ApplicationController

  def index
    @recent_ideas = Idea.last(10)
  end
end
