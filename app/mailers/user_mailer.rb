class UserMailer < ActionMailer::Base
  default :from => "no_reply@gmail.com" # if from is not specified it will be set as from.
  def create_email(idea)
  	addresses = Array.new()
  	idea.users.each {|x| addresses << x[:email]}
  	mail(:to => addresses, :subject => "Your Idea was created")
  end

  def update_email(idea)
  	addresses = Array.new()
  	idea.users.each {|x| addresses << x[:email]}
  	mail(:to => addresses, :subject => "Your Idea was updated")
  end

  def delete_email(idea)
  	addresses = Array.new()
  	idea.users.each {|x| addresses << x[:email]}
  	mail(:to => addresses, :subject => "Your Idea was deleted")
  end
end