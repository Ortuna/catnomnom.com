class Cat
  include DataMapper::Resource

  property :guid, String, :key => true
  property :title, String, :required => true
  property :url, String, :required => true

  validates_with_method :url, :method  => :validate_proper_url


  class << self
    def get_fresh_cat_list
      cats      = []
      list_locations.each do |json_url|
        body    = parse_json_from_url(json_url) 
        entries = body["data"]["children"].map do |entry|
          {
           :url   => entry["data"]["url"],
           :title => entry["data"]["title"],
           :guid  => entry["data"]["permalink"]
          }
        end # map
        cats = cats + entries
      end #each
      cats
    end #get_fresh_cat_list

    def create_cats_from_list
      get_fresh_cat_list.map do |hash|
        cat  = Cat.new
        cat.attributes = hash
        cat
      end
    end

    private

    def parse_json_from_url(json_url)
      require 'net/http'
      MultiJson.load(Net::HTTP.get_response(URI.parse(json_url)).body)
    end

    def list_locations
      [
        "http://www.reddit.com/r/kittens.json",
        "http://www.reddit.com/r/cats.json",
        "http://www.reddit.com/r/cats/new.json"
      ]
    end    
  end #class << self

  private
  def validate_proper_url
    is_valid_url?(url) ? true : [false, "Invalid url"]
  end

  def is_valid_url?(url)
    url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  end
end