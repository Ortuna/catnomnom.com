class CatnomnomCom
  register Padrino::MultiJson

  before :each do
    content_type :json
  end

  get '/cats', :provides => [:html, :json] do
    @cats = Cat.all(
              :limit => extract_limit_from_params(params[:limit])
            )
    json @cats
  end


  private
  def extract_limit_from_params(limit = 0, default = 25)
    limit = (params[:limit] && params[:limit].to_i) || default
    limit == 0 ? default : limit 
  end
end