require 'spec_helper'

describe Questionnaire do
  before :each do
    @attr = { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :point => 0, }
    @cat = Category.create({ :name => "Example", :popularity => 0})
  end

  it "should require a category" do
    questionnaire = Questionnaire.new @attr
    questionnaire.should_not be_valid
  end

  it "should require a category" do
    questionnaire = @cat.questionnaires.new @attr
    questionnaire.should be_valid
  end


  it "should require a title" do
    questionnaire = @cat.questionnaires.new @attr.merge(:title =>"")
    questionnaire.should_not be_valid
  end

  it "should require a difficulty" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:difficulty => nil)
    questionnaire.should_not be_valid
  end

  it "should require a popularity" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:popularity => nil)
    questionnaire.should_not be_valid
  end

  it "should require a cost" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:cost => nil)
    questionnaire.should_not be_valid
  end

  it "should require points" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:point => nil)
    questionnaire.should_not be_valid
  end

  it "Popularity should be numeric" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:popularity => "a")
    questionnaire.should_not be_valid
  end

  it "Difficulty should be numeric" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:difficulty => "a")
    questionnaire.should_not be_valid
  end

  it "Cost should be numeric" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:cost => "a")
    questionnaire.should_not be_valid
  end
  it "Point should be numeric" do
    questionnaire =  @cat.questionnaires.new @attr.merge(:point => "a")
    questionnaire.should_not be_valid
  end

  describe "Difficulty should be between 0 and 4" do
    it "Difficulty should be >= 0" do
      questionnaire =  @cat.questionnaires.new @attr.merge(:difficulty => -1)
      questionnaire.should_not be_valid
    end
    it "Difficulty should be < 5" do
      questionnaire =  @cat.questionnaires.new @attr.merge(:difficulty => 5)
      questionnaire.should_not be_valid
    end
    it "Difficulty should be between 0 and 4" do
      questionnaire =  @cat.questionnaires.new @attr.merge(:difficulty => 1)
      questionnaire.should be_valid
    end

  end

end
