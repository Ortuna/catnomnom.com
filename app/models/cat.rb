class Cat
  include DataMapper::Resource

  property :guid, String, :key => true
  property :title, String, :required => true
  property :url, String, :required => true

  validates_presence_of :url, :title, :guid
  validates_with_method :url, :method  => :validate_proper_url
  validates_with_method :url, :method  => :validate_imgur_url

  before :save, :update_imgur_to_direct_image_url

  class << self
    def destroy_all
      all.each {|x| x.destroy}
    end

    def save_objects(objects = create_objects)
      objects.each do |cat|
        cat.save
      end
    end

    def query_locations_for_objects(locations = list_locations)
      cats      = []
      locations.each do |json_url|
        body    = parse_json_from_url(json_url) 
        entries = body['data']['children'].map do |entry|
          {
           :url   => entry['data']['url'],
           :title => entry['data']['title'],
           :guid  => entry['data']['permalink']
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
      #TODO: Extract to YAML
      [
        "http://www.reddit.com/r/kittens.json",
        "http://www.reddit.com/r/cats.json"
      ]
    end
  end #class << self

  private

  def update_imgur_to_direct_image_url
    matches  = match_imgur_parts
    self.url = "http://imgur.com/" + matches[1] + "l" + ".jpg"
  end

  def validate_imgur_url
    is_valid_imgur_url? ? true : [false, "Not an imgur url"]
  end

  def match_imgur_parts(url = self.url)
    matches = url.match(/.*imgur\.com\/(\w*)/)
  end

  def is_valid_imgur_url?(url = self.url)
    url =~ /.*imgur\.com\/(\w*)/
  end

  def validate_proper_url(url = self.url)
    is_valid_url?(url) ? true : [false, "Invalid url"]
  end

  def is_valid_url?(url = self.url)
    url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  end
end