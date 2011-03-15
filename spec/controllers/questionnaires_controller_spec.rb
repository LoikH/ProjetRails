require 'spec_helper'

describe QuestionnairesController do

  before :each do
    @attr = { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :nb_questions => 0, :point => 0 } 
    @cat = Category.create({ :name => "Example", :popularity => 0}
)

  end

  describe "get index" do
    it "should have a successful response" do
      get :index
      response.should be_success
    end
  end

  describe "get show" do
    it "should be able to see a questionnaire" do
      #we create a questionnaire to see it
      @cat.questionnaires.create @attr
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
      #we create a questionnaire to edit it
      @cat.questionnaires.create @attr
      get :edit, :id =>1
      response.should be_success
    end
  end

  describe "Questionnaire creation success" do

    it "should create a questionnaire" do
      lambda do
        post :create, :questionnaire => @attr
      end.should change(Questionnaire, :count).by(1)
    end

    it "should be redirected to the questionnaire" do
      post :create, :questionnaire => @attr
      response.should redirect_to(questionnaire_path(assigns(:questionnaire)))
    end
  end

  describe "Questionnaire update success" do
    before :each do
      #we create a questionnaire to edit it
      @cat.questionnaires.create @attr
    end

    it "should edit a questionnaire" do
      #TODO !!!
    end

    it "should be redirected to the questionnaire" do
      #we create an other one to edit the first one with
      c = @cat.questionnaires.new
      c.title = "new"
      post :update, :id =>1, :questionnaire => c
      response.should redirect_to(questionnaire_path(assigns(:questionnaire)))
    end
  end

  describe "Questionnaire destroy success" do
    before :each do
      #we create a questionnaire to destroy it
      @cat.questionnaires.create @attr
    end

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
