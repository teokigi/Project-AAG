require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/booking.rb')

get '/bookings' do
	@bookings = Booking.find_all
	@members = Member.find_all
	@gym_classes = GymClass.find_all
	@sessions = Session.find_all
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

post '/bookings/:booking_id/:session_id/toggle' do
	toggling_class = Booking.find_by_id(params['booking_id'].to_i)
	toggling_class.toggle_status
	redirect to("/bookings/#{params['session_id']}/index")
end
