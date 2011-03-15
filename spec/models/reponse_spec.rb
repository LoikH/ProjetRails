require 'spec_helper'

describe Reponse do
  before :each do
    @attr = { :title => "Example", :correct => false}
    @c =  Category.create({ :name => "Example", :popularity => 0})
    @q = @c.questionnaires.create( { :title => "Mon questionnaire", :difficulty => 0, :popularity => 0, :cost => 0, :point => 0 })
    @quest = @q.questions.create( { :title => "Example", :points => 2})
  end


  it "should require a question" do
    reponse = Reponse.new @attr
    reponse.should_not be_valid
  end

  it "should require a question" do
    reponse = @quest.reponses.new @attr
    reponse.should be_valid
  end

  it "should require a title" do
    reponse = @quest.reponses.new @attr.merge(:title =>"")
    reponse.should_not be_valid
  end

end
