require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe SessionsHelper do
  before :each do
    u = User.create(:name => "admin", :email => "admin@a.com", :password => "admin", :admin => true)
    session[:user] = u
  end

  describe "signout" do
    it "deletes the user of the session" do
      signout
      session[:user].should == nil
    end
  end

  describe "session_admin?" do
    it "should return true when it's an admin" do
      session_admin?.should == true
    end
    it "should return false when it's not an admin" do
      signout
      u = User.create(:name => "toto", :email => "toto@a.com", :password => "toto", :admin => false)
      session[:user] = u
      session_admin?.should == false
    end
  end

end
