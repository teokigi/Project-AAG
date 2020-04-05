require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/customer.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/session.rb')
require_relative('../models/booking.rb')
also_reload( '../models/*' )

get '/bookings/:session_id/index' do
	@all_bookings = Bookings.find_all
	erb(:"/bookings/index")
end
get '/sessions/:class_id/index' do
	@gym_class = GymClass.find_by_id(params['class_id'].to_i)
	@sessions = Session.find_sessions_with_gym_class_id(@gym_class.id)
	erb(:"sessions/index")
end
