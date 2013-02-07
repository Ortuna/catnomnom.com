CatnomnomCom.controllers  do
  layout :nomnom
  
  get :index do
    render :index
  end

  get :cats do
    @cats = Array.new
    render @cats
  end
  
end
