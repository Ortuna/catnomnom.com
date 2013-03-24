class CatnomnomCom
  register Padrino::MultiJson
  
  layout :app

  before :each do
    content_type :json
  end

  get '/' do
    render :index
  end

  get '/cats', :provides => [:html, :json] do
    limit = params[:limit].to_i || 25
    @cats = Cat.all(:limit => limit, :offset => rand(Cat.count)).sort_by{rand}
    json @cats
  end

end