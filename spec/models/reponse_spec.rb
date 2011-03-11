require 'spec_helper'

describe Reponse do
  before :each do
    @attr = { :title => "Example", :correct => false}
  end

  it "should require a title" do
    reponse = Reponse.new @attr.merge(:title =>"")
    reponse.should_not be_valid
  end

end
