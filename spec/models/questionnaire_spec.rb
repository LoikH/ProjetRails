require 'spec_helper'

describe Questionnaire do
  before :each do
    @attr = { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :nb_questions => 0, :point => 0, }
  end

  it "should require a title" do
    questionnaire = Questionnaire.new @attr.merge(:title =>"")
    questionnaire.should_not be_valid
  end

  it "should require a difficulty" do
    questionnaire = Questionnaire.new @attr.merge(:difficulty => nil)
    questionnaire.should_not be_valid
  end

  it "should require a popularity" do
    questionnaire = Questionnaire.new @attr.merge(:popularity => nil)
    questionnaire.should_not be_valid
  end

  it "should require a cost" do
    questionnaire = Questionnaire.new @attr.merge(:cost => nil)
    questionnaire.should_not be_valid
  end

  it "should require points" do
    questionnaire = Questionnaire.new @attr.merge(:point => nil)
    questionnaire.should_not be_valid
  end

  it "Popularity should be numeric" do
    questionnaire = Questionnaire.new @attr.merge(:popularity => "a")
    questionnaire.should_not be_valid
  end

  it "Difficulty should be numeric" do
    questionnaire = Questionnaire.new @attr.merge(:difficulty => "a")
    questionnaire.should_not be_valid
  end

  it "Cost should be numeric" do
    questionnaire = Questionnaire.new @attr.merge(:cost => "a")
    questionnaire.should_not be_valid
  end
  it "Point should be numeric" do
    questionnaire = Questionnaire.new @attr.merge(:point => "a")
    questionnaire.should_not be_valid
  end

  describe "Difficulty should be between 0 and 4" do
    it "Difficulty should be >= 0" do
      questionnaire = Questionnaire.new @attr.merge(:difficulty => -1)
      questionnaire.should_not be_valid
    end
    it "Difficulty should be < 5" do
      questionnaire = Questionnaire.new @attr.merge(:difficulty => 5)
      questionnaire.should_not be_valid
    end
    it "Difficulty should be between 0 and 4" do
      questionnaire = Questionnaire.new @attr.merge(:difficulty => 1)
      questionnaire.should be_valid
    end

  end


end
