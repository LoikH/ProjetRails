require 'spec_helper'

describe Category do
  before :each do
    @attr = { :name => "Example", :popularity => 0, :nb_mcq => 0}
  end

  it "should require a name" do
    category = Category.new @attr.merge(:name =>"")
    category.should_not be_valid
  end

  it "should require a popularity" do
    category = Category.new @attr.merge(:popularity => nil)
    category.should_not be_valid
  end

  it "should require a number of questionnaire" do
    category = Category.new @attr.merge(:nb_mcq => nil)
    category.should_not be_valid
  end

  it "should fit with the right regexp" do
    category = Category.new @attr
    category.should be_valid
  end

  it "should reject wrong type of name" do
    wrong_names = ["1cat" "example" "EXAMPLE"]
    wrong_names.each do |name|
      category = Category.new @attr.merge(:name => name)
      category.should_not be_valid
    end
  end

  it "should not have two same names" do
    cat1 = Category.create @attr
    cat2 = Category.new @attr
    cat2.should_not be_valid
  end

end
