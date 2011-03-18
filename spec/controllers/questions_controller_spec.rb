require 'spec_helper'

describe QuestionsController do
 before :each do
    @attr = { :title => "Example", :points => 1}
    @cat = Category.create({ :name => "Example", :popularity => 0})
    @qaire = @cat.questionnaires.create({:title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :point => 0})
	@q = @qaire.questions.create @attr
	 
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
    it "should be able to see a question" do
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

  describe "Question creation success" do

    it "should create a question" do
      lambda do
        post :create, :question => { :title => "Other example", :points => 1, :questionnaire_id => 1}
        end.should change(Question, :count).by(1)
    end

    it "should be redirected to the question" do
      post :create, :question => { :title => "Other example", :points => 1, :questionnaire_id => 1}
      response.should redirect_to(question_path(assigns(:question)))
    end
  end

  describe "Question update success" do

    it "should update a question" do
      post :update, :id =>1, :question=>{"title"=>"new"}
      @q.reload
      @q.title.should  == "new"
    end

    it "should be redirected to the question" do
      post :update, :id =>1, :question=>{:title=>"new"}
      response.should redirect_to(question_path(assigns(:question)))
    end
  end

  describe "Question destroy success" do

    it "should destroy a question" do
      lambda do
        post :destroy, :id => 1
      end.should change(Question, :count).by(-1)
    end

    it "should redirect to the index of questions" do
      post :destroy, :id => 1
      response.should redirect_to(questions_path)
    end
  end
end
