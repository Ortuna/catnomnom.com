require 'spec_helper'

describe Cat do

  before :all do
    Cat.all.each {|x| x.destroy}
  end

  before :each do 
    @cat = Cat.new
    @cat.title = "Dobby"
    @cat.url = "http://www.google.com"
    @cat.guid = "1234 %d" % Random.rand(5000) 
  end

  it "Should have the cat model" do
    c = Cat.new
    c.should_not be_nil
  end


  it "Should be able be able save a basic model" do
    @cat.save.should == true
  end

  it "Should not save an invalid url" do
    @cat.url = nil
    @cat.save.should == false

    @cat.url = "hhtp://www.fazeb00k.net"
    @cat.save.should == false
  end

  it "Should be able to get a list of new cats" do
    cats = Cat.get_fresh_cat_list
    cats.size.should >= 1
    cats.first[:url].should_not   be_nil
    cats.first[:title].should_not be_nil
    cats.first[:guid].should_not be_nil
  end

  it "Should create an array of models from the list of cats" do
    cats = Cat.create_cats_from_list
    cats.first.class.should == Cat
    cats.first.save.should == true
  end  
end