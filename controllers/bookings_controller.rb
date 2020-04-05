require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/customer.rb')
require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/booking.rb')
also_reload( '../models/*' )

get '/bookings/:session_id/index' do
	@members = Member.find_all
	@session = Session.find_by_id(params['session_id'].to_i)
	@gym_class = GymClass.find_by_id(session.gym_class_id)
	@all_bookings = Bookings.find_all_bookings_by_session_id(params['session_id'].to_i)
	erb(:"/bookings/#{params['session_id']}/index")
end
get '/sessions/:class_id/index' do

	@sessions = Session.find_sessions_with_gym_class_id(@gym_class.id)
	erb(:"sessions/index")
end
