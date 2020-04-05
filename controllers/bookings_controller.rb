require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/booking.rb')
also_reload( '../models/*' )

get '/bookings/:session_id/index' do
	@members = Member.find_all
	@session = Session.find_by_id(params['session_id'].to_i)
	@gym_class = GymClass.find_by_id(@session.gym_class_id)
	@all_bookings = Booking.find_bookings_with_session_id(params['session_id'].to_i)
	erb(:"/bookings/index")
end
