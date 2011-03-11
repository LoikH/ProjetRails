require 'spec_helper'

describe Question do
  before :each do
    @attr = { :title => "Example", :points => 2}
  end

  it "should require a title" do
    question = Question.new @attr.merge(:title =>"")
    question.should_not be_valid
  end

  it "should require a number of points" do
    question = Question.new @attr.merge(:points => nil)
    question.should_not be_valid
  end

  it "should not have two same titles" do
    quest1 = Question.create @attr
    quest2 = Question.new @attr
    quest2.should_not be_valid
  end

end
