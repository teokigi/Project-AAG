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
	@bookings = Booking.find_bookings_with_session_id(params['session_id'].to_i)
	erb(:"/bookings/index")
end

post '/bookings' do
	new_session = Booking.new(@params)
	new_session.create
	redirect to("/bookings/#{@params['session_id']}/index")
end

post '/bookings/:booking_id/:session_id/delete' do
	Booking.delete_by_id(params['booking_id'].to_i)
	redirect to("/bookings/#{params['session_id']}/index")
end
