require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload( '../models/*' )

get '/sessions/:class_id/index' do
	@class_id = params['class_id'].to_i
	@sessions = Sessions.find_by_gym_class_id(@class_id)
	erb(:"/sessions/index")
end
