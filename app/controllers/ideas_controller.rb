class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  
  #Authentication
  before_filter :authenticate_user!, except: "all"
    
  #loading @ideas
  before_filter :load_resource 
  
  #Authorization
  load_and_authorize_resource except: "all"
  
  def index
   @title = "Your ideas"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
   
    @list_users = User.all
    @list_users.delete(current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @list_users = User.all
    @list_users.delete(current_user)
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @list_users = User.all
    @list_users.delete(current_user)
    @idea = Idea.new(params[:idea])
    @users = User.where(:id => params[:organizing_team])
    @users << current_user
    @users << User.where(:email=>"cbel@devspark.com")
    @idea.users << @users 
    respond_to do |format|
      if @idea.save
        UserMailer.create_email(@idea).deliver
        format.html { redirect_to ideas_url, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @list_users = User.all
    @list_users.delete(current_user)

    @idea = Idea.find(params[:id])
    @users = User.where(:id => params[:organizing_team])
    @idea.users << @users 
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        UserMailer.update_email(@idea).deliver
        format.html { redirect_to ideas_url, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    UserMailer.delete_email(@idea).deliver
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end
  
  
  def all
    if params[:tag]
      @title = "Ideas tagged by &ldquo;#{params[:tag]}&rdquo;".html_safe
      @ideas = Idea.tagged_with(params[:tag])
    else
      @title = "Ideas"
      @ideas = Idea.all
    end
    respond_to do |format|
      format.html { render action: :index }
      format.json { render json: @ideas }
    end
  end
  
  private
  def load_resource
    @ideas = current_user.ideas if current_user
  end
  
end
