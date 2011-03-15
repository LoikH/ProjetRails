require 'spec_helper'

describe Question do
  before :each do
    @attr = { :title => "Example", :points => 2}
    @c =  Category.create({ :name => "Example", :popularity => 0})
    @q = @c.questionnaires.create( { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :nb_questions => 0, :point => 0 })
    
  end

  it "should require a questionnaire" do
    question = Question.new @attr
    question.should_not be_valid
  end

  it "should require a questionnaire" do
    question = @q.questions.new @attr
    question.should be_valid
  end


  it "should require a title" do
    question = @q.questions.new @attr.merge(:title =>"")
    question.should_not be_valid
  end

  it "should require a number of points" do
    question = @q.questions.new @attr.merge(:points => nil)
    question.should_not be_valid
  end

  it "Number of points should be numeric" do
    question =  @q.questions.new @attr.merge(:points => "a")
    question.should_not be_valid
  end

  it "should not have two same titles" do
    quest1 = @q.questions.create @attr
    quest2 = @q.questions.new @attr
    quest2.should_not be_valid
  end

end
