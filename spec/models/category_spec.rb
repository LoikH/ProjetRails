require 'spec_helper'

describe Category do
  before :each do
    @attr = { :name => "Example", :popularity => 0}
  end

  it "should require a name" do
    category = Category.new @attr.merge(:name =>"")
    category.should_not be_valid
  end

  it "should require a popularity" do
    category = Category.new @attr.merge(:popularity => nil)
    category.should_not be_valid
  end

  it "should fit with the right regexp" do
    category = Category.new @attr
    category.should be_valid
  end

  it "should not have two same names" do
    cat1 = Category.create @attr
    cat2 = Category.new @attr
    cat2.should_not be_valid
  end

end
