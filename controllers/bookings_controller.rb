require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload( '../models/*' )

get '/bookings' do
	# @all_bookings = Bookings.find_all
	erb(:"/bookings/index")
end
