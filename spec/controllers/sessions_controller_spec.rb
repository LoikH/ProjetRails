require 'spec_helper'

describe SessionsController do

  before :each do
    @attr = { :name => "Toto", :email => "toto@toto.fr", :password => "toto", :password_confirmation => "toto"}
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      User.create @attr
      session = {:name => "toto", :password => "toto"}
      get :create, :session => session
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get :destroy
      response.should be_success
    end
  end

end
