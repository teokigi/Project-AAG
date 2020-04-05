require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload( '../models/*' )

get '/gym_classes/' do
	@classes = GymClasses.find_all
	erb(:"gym_classes/index")
end
