require 'spec_helper'

describe ReponsesController do
  before :each do
    @attr = { :title => "Example", :correct => false}
    @cat = Category.create({ :name => "Example", :popularity => 0})
    @qaire = @cat.questionnaires.create({:title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :point => 0})
	@q = @qaire.questions.create ({ :title => "Example", :points => 1})
	@r = @q.reponses.create @attr
	 
    #We do our tests as an admin
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
    it "should be able to see a reponse" do
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

  describe "Reponse creation success" do

    it "should create a reponse" do
      lambda do
        post :create, :reponse => { :title => "Other example", :correct => false, :question_id => 1}
        end.should change(Reponse, :count).by(1)
    end

    it "should be redirected to the reponse" do
      post :create, :reponse => { :title => "Other example", :correct => false, :question_id => 1}
      response.should redirect_to(reponse_path(assigns(:reponse)))
    end
  end

  describe "Reponse update success" do

    it "should update a reponse" do
      post :update, :id =>1, :reponse=>{"title"=>"new"}
      @r.reload
      @r.title.should  == "new"
    end

    it "should be redirected to the reponse" do
      post :update, :id =>1, :reponse=>{:title=>"new"}
      response.should redirect_to(reponse_path(assigns(:reponse)))
    end
  end

  describe "Reponse destroy success" do

    it "should destroy a reponse" do
      lambda do
        post :destroy, :id => 1
      end.should change(Reponse, :count).by(-1)
    end

    it "should redirect to the index of reponses" do
      post :destroy, :id => 1
      response.should redirect_to(reponses_path)
    end
  end
end
