require( 'sinatra' )
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
	@new_booking = Booking.new(@params).create
	@bookings = Booking.find_all
	@members = Member.find_all
	@gym_classes = GymClass.find_all
	@sessions = Session.find_all
	# redirect to("/bookings")
	erb(:"/bookings/index")
end

post '/bookings/:booking_id/delete' do
	Booking.delete_by_id(params['booking_id'].to_i)
	redirect to("/bookings")
end
