require 'spec_helper'

describe Cat do

  before :all do
    
  end

  before :each do 
    Cat.destroy_all
    @cat = Cat.new
    @cat.title = "Dobby"
    @cat.url = "http://imgur.com/test"
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

  it "Should not save a non-imgur url" do
    @cat.url = "http://www.google.com"
    @cat.save.should == false
    
    @cat.url = "http://i.imgur.com/2MeZqpN.gif"
    @cat.save.should == true
  end

  it "Should fix imgur url so it points to a direct image" do
    @cat.url = "http://imgur.com/9O8TYbj"
    @cat.save
    @cat.url.should == "http://imgur.com/9O8TYbjl.jpg"

    @cat.url = "http://i.imgur.com/9O8TYbj"
    @cat.save
    @cat.url.should == "http://imgur.com/9O8TYbjl.jpg"
  end

  it "#query_locations_for_objects should be able to get a list of new cats", :external => true do
    cats = Cat.query_locations_for_objects
    cats.size.should >= 1
    cats.first[:url].should_not   be_nil
    cats.first[:title].should_not be_nil
    cats.first[:guid].should_not be_nil
  end

  it "#create_objects should create an array of models from the list of cats", :external => true do
    cats = Cat.create_objects
    cats.first.class.should == Cat
    cats.first.save.should == true
  end

  it "#save_new_objects Should insert all objects into the db", :external => true do
    Cat.destroy_all
    cats = Cat.create_objects
    Cat.save_objects([cats[0], cats[1]])
    Cat.all.count.should == 2
  end
end