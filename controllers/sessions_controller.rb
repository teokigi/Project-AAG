require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload( '../models/*' )

get '/sessions' do
	# @all_sessions = Sessions.find_all
	erb(:"/sessions/index")
end
