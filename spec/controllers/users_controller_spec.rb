require 'spec_helper'

describe UsersController do

  before :each do
    @attr = { :name => "Name", :email => "mail@domain.com", :password => "pass", :password_confirmation =>"pass"}
    #On fait nos test en tant qu'admin
    @u = User.create(:name => "admin", :email => "admin@a.com", :password => "admin", :admin => true)
    session[:user] = @u
  end

  describe "get index" do
    it "should have a successful response" do
      get :index
      response.should be_success
    end
  end

  describe "get show" do
    it "should be able to see a user" do
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
    it "should have be successful " do
      get :edit, :id =>1
      response.should be_success
    end
  end

  describe "User creation success" do

    it "should create a user" do
      lambda do
        post :create, :user => @attr
        end.should change(User, :count).by(1)
    end

    it "should be redirected to the user" do
      post :create, :user => @attr
      response.should redirect_to(user_path(assigns(:user)))
    end
  end

  describe "User update success" do

    it "should edit a user" do
      post :update, :id=>1, :user => {:name=>"new", :password => "mdp", :password_confimation => "mdp"}
      @u.reload
      @u.name.should  == "new"
    end

    it "should be redirected to the user" do
      post :update, :id=>1, :user => {:name => "toto", :password => "toto", :password_confirmation => "toto"}
      response.should redirect_to(user_path(assigns(:user)))
    end
  end

  describe "User destroy success" do

    it "should destroy a user" do
      lambda do
        post :destroy, :id => 1
      end.should change(User, :count).by(-1)
    end

    it "should redirect to the index of users" do
      post :destroy, :id => 1
      response.should redirect_to(users_path)
    end
  end
end
