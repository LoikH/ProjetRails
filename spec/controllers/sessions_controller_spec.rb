require 'spec_helper'

describe SessionsController do

  before :each do
    @attr = { :name => "toto", :email => "toto@toto.fr", :password => "toto"}
    @user = User.create @attr
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create' should redirect to root path" do
    it "should be successful" do
      session = {:name => "toto", :password => "toto"}
      get :create, :session => {"name" => "toto", "password" => "toto"}
      response.should redirect_to (root_path)
    end
  end

  describe "GET 'destroy' redirects to root path" do
    it "should be successful" do
      get :destroy
      response.should redirect_to(root_path)
    end
  end

end
