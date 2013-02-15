class Cat
  include DataMapper::Resource

  property :guid, String, :key => true
  property :title, String, :required => true
  property :url, String, :required => true

  validates_presence_of :url, :title, :guid
  validates_with_method :url, :method  => :validate_proper_url
  validates_with_method :url, :method  => :validate_imgur_url


  class << self
    def destroy_all
      all.each {|x| x.destroy}
    end

    def save_objects(objects = create_cat_objects)
      objects.each do |cat|
        p "Saving cat #{cat.guid}"
        cat.save
      end
    end

    def query_locations_for_objects(locations = list_locations)
      cats      = []
      locations.each do |json_url|
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

    def create_objects(objects = query_locations_for_objects)
      objects.map do |hash|
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
  def validate_imgur_url
    #improve!
    # tag group matches
    # move out image change logic
    return [false, "Not an imgur url"] if self.url.nil?
    
    matches = self.url.match(/.*imgur\.com\/(\w*)/)
    return [false, "Not an imgur url"] if matches.nil? or matches[1] == "a"
    self.url = "http://imgur.com/" + matches[1] + "l" + ".jpg"
  end

  def validate_proper_url
    is_valid_url?(url) ? true : [false, "Invalid url"]
  end

  def is_valid_url?(url)
    url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  end
end