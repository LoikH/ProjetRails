require 'spec_helper'

describe QuestionnairesController do

  before :each do
    @attr = { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :point => 0 } 
    @cat = Category.create({ :name => "Example", :popularity => 0})
	@qaire = @cat.questionnaires.create @attr
    #On fait nos test en tant qu'admin
    u = User.create(:name => "admin", :email => "admin@a.com", :password => "admin", :admin => true)
    session[:user] = u
  end

  describe "get index" do
    it "should have a successful response" do
      get :index
      response.should be_success
    end
  end

  describe "get show" do
    it "should be able to see a questionnaire" do
      get :show, :id =>1
      response.should be_success
    end
  end

  describe "get new" do
    it "should have a successful response" do
      get :new
      response.should be_success
    end
  end

  describe "get edit" do
    it "should have a successful response" do
      get :edit, :id =>1
      response.should be_success
    end
  end

  describe "Questionnaire creation success" do

    it "should create a questionnaire" do
      lambda do
        post :create, :questionnaire => @attr.merge(:category_id =>1)
      end.should change(Questionnaire, :count).by(1)
    end

    it "should be redirected to the questionnaire" do
      post :create, :questionnaire => @attr.merge(:category_id => 1)
      response.should redirect_to(questionnaire_path(assigns(:questionnaire)))
    end
  end

  describe "Questionnaire update success" do

    it "should edit a questionnaire" do
      post :update, :id =>1, :questionnaire=>{:title=>"new"}
      @qaire.reload
      @qaire.title.should  == "new"
    end

    it "should be redirected to the questionnaire" do
      post :update, :id =>1, :questionnaire => {:title=>"new"}
      response.should redirect_to(questionnaire_path(assigns(:questionnaire)))
    end
  end

  describe "Questionnaire destroy success" do

    it "should destroy a questionnaire" do
      lambda do
        post :destroy, :id => 1
      end.should change(Questionnaire, :count).by(-1)
    end

    it "should redirect to the index of questionnaires" do
      post :destroy, :id => 1
      response.should redirect_to(questionnaires_path)
    end
  end

end
