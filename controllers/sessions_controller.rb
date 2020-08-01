require( 'sinatra' )
require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')
require_relative('../models/member.rb')
require_relative('../models/booking.rb')

get '/session/:session_id' do
	@session = Session.find_by_id(params['session_id'].to_i)
	@gym_class = GymClass.find_by_id(Session.find_by_id(@session.id).gym_class_id)
	@bookings = Booking.find_all
	@bookings = @bookings.keep_if{|booking| booking.session_id == @session.id.to_i}
	erb(:"sessions/index")
end

post '/sessions' do
	new_session = Session.new(@params)
	new_session.create
	redirect to("/gym_classes")
end

post '/sessions/:session_id/delete' do
	Session.delete_by_id(params['session_id'].to_i)
	redirect to("/gym_classes")
end
