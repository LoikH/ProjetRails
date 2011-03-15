require 'spec_helper'

describe CategoriesController do

  before :each do
    @attr = { :name => "Example", :popularity => 0}
  end

  describe "get index" do
    it "should have a successful response" do
      get :index
      response.should be_success
    end
  end

  describe "get show" do
    it "should be able to see a category" do
      #we create a category to see it
      Category.create @attr
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
      #we create a category to edit it
      Category.create @attr
      get :edit, :id =>1
      response.should be_success
    end
  end

  describe "Category creation success" do
    before :each do
      @attr = {:name => "Example"}
    end

    it "should create a category" do
      lambda do
        post :create, :category => @attr
        end.should change(Category, :count).by(1)
    end

    it "should be redirected to the category" do
      post :create, :category => @attr
      response.should redirect_to(category_path(assigns(:category)))
    end
  end

  describe "Category update success" do
    before :each do
      #we create a category to edit it
      Category.create @attr
    end

    it "should edit a category" do
      #TODO !!!
    end

    it "should be redirected to the category" do
      #we create an other one to edit the first one with
      c = Category.new
      c.name = "new"
      post :update, :id =>1, :category => c
      response.should redirect_to(category_path(assigns(:category)))
    end
  end

  describe "Category destroy success" do
    before :each do
      #we create a category to destroy it
      Category.create @attr
    end

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
