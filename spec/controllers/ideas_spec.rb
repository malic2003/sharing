require "spec_helper"

describe IdeasController do
  include Devise::TestHelpers

  describe "without authentication" do
    describe "GET #index" do
      it "should redirect to sign_in" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
        expect(response.code).to eq('302')
      end
    end
  end

  describe "with authentication" do
    before :each do
      @user = User.create!(email: 'test@gmail.com', password: 'test')
      sign_in @user
    end

    describe "GET #index" do
      it "should respond successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.code).to eq('200')
      end

      it "should render the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "should load @ideas" do

        idea1 = Idea.new content:"idea1" 
        idea2 = Idea.new content:"idea2" 
        idea1.user = idea2.user = @user
        idea1.save
        idea2.save
        
        get :index
        expect(assigns(:ideas)).to match_array([idea1, idea2])
      end
    end
    describe "POST #create" do
      it "should respond successfully with an HTTP 200 status code (Create idea page)" do
        post :create
        expect(response).to be_success
        expect(response.code).to eq('200')
      end
      it "should create an idea and redirect to the index" do
        post :create, content:'idea1'
        expect(response).to be_success
        expect(response.code).to eq('200')
      end
    end
  end
end