desc "Gets new cats from the locations and saves it"
task :update_cats do 
  Cat.save_objects
end