require 'spec_helper'

describe User do
  before :each do
	@attr = { :name => "Toto", :email => "a@a.fr", :password => "foobar", :password_confirmation => "foobar" }
  end

  it "should require a name" do
	user = User.new @attr.merge(:name => "")
	user.should_not be_valid
  end

  it "should require name > 2 " do
	user = User.new @attr.merge(:name => "a")
	user.should_not be_valid
  end

  it "should require name < 30 " do
	user = User.new @attr.merge(:name => "a" * 31)
	user.should_not be_valid
  end

  it "should accept valid emails" do
	emails = %w[foo@bar.com foo@bar.foo.com foo.bar@foo.com]
	emails.each do |email|
		user = User.new @attr.merge(:email => email)
		user.should be_valid
	end
  end 

  it "should not accept invalid emails" do
	emails = %w[foo@bar foobar.foo.com @foo.barfoo.com]
	emails.each do |email|
		user = User.new @attr.merge(:email => email)
		user.should_not be_valid
	end
  end 

  it "should not accept differents emails and name" do
	User.create! @attr
	user = User.new @attr
  	user.should_not be_valid
  end 

  it "should require a password" do
	user = User.new @attr.merge(:password => "")
	user.should_not be_valid
  end

  it "should have password and confirmation matching" do
	user = User.new @attr.merge(:password_confirmation => "barfoo")
	user.should_not be_valid
  end

  it "should have correct password" do
	user = User.new @attr
	user.should be_valid if user.password_ok?("foobar")
  end

end
