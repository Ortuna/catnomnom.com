require 'spec_helper'

describe CatnomnomCom do 
  
  before :all do
    Cat.destroy_all
    Cat.save_objects
  end

  def get_request_cats(extend = "")
    get "/cats#{extend}"
    MultiJson.load(last_response.body)    
  end

  it "Sanity Check" do
    get '/cats'
    last_response.should be_ok
  end

  it "Should get a list of cats" do
    cats = get_request_cats
    cats.size.should > 0
  end

  it "Should be a proper cat" do
    cats = get_request_cats
    cats.first["guid"].should_not be_nil
    cats.first["title"].should_not be_nil
    cats.first["url"].should_not be_nil
  end

  it "Should take a limit" do 
    cats = get_request_cats "?limit=5"
    cats.count.should == 5

    cats = get_request_cats "?limit=10"
    cats.count.should == 10
  end
end