require 'spec_helper'

describe CategoriesController do

  before :each do
    @attr = { :name => "Example", :popularity => 0}
	@cat = Category.create @attr
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
    it "should be able to see a category" do
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

  describe "Category creation success" do

    it "should create a category" do
      lambda do
        post :create, :category => {:name => "Other Example"}
        end.should change(Category, :count).by(1)
    end

    it "should be redirected to the category" do
      post :create, :category => {:name => "Other Example"}
      response.should redirect_to(category_path(assigns(:category)))
    end
  end

  describe "Category update success" do

    it "should update a category" do
      post :update, :id =>1, :category=>{:name=>"new"}
      @cat.reload
      @cat.name.should  == "new"
    end

    it "should be redirected to the category" do
      #we create an other one to edit the first one with
      post :update, :id =>1, :category=>{:name=>"new"}
      response.should redirect_to(category_path(assigns(:category)))
    end
  end

  describe "Category destroy success" do

    it "should destroy a category" do
      lambda do
        post :destroy, :id => 1
      end.should change(Category, :count).by(-1)
    end

    it "should redirect to the index of categories" do
      post :destroy, :id => 1
      response.should redirect_to(categories_path)
    end
  end

end
