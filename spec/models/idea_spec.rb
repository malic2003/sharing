require "spec_helper"
# require 'ruby-debug'

describe Idea do
  it "should validate the content on creation" do
    idea = Idea.new
    # debugger
    expect(idea.save).to eq(false)
    #expect(idea.errors.size).to eq(1)
    expect(idea.errors[:content]).to eq(["can't be blank"])
  end

  it "should validate if the idea had the proper tag" do
    user = User.create email:"pepe@mail.com", password:"1234" 
    idea = Idea.new tag_list: "tag1, tag2, tag3", content: "algo"
    idea.user = user
    idea.save
    #debugger
    expect(idea.tag_list).to eq(["tag1", "tag2", "tag3"])
    expect(idea.tags.size).to eq(3)
  end
  
  it "validate the user asociate to the idea" do
    user = User.create email:"pepe@mail.com", password:"1234" 
    idea = Idea.new content:"idea" 
    idea.user = user
    idea.save
    expect(idea.user).to eq(user)
  end
end
