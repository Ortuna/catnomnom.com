class CatnomnomCom
  register Padrino::MultiJson

  before :each do
    content_type :json
  end

  get '/cats' do
    limit = (params[:limit] && params[:limit].to_i) || 25
    @cats = Cat.all(:limit => limit)

    json @cats
  end
end