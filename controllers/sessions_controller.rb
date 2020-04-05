require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/session.rb')
require_relative('../models/gym_class.rb')
also_reload( '../models/*' )

get '/sessions/:class_id/index' do
	@gym_class = GymClass.find_by_id(params['class_id'].to_i)
	@sessions = Session.find_sessions_with_gym_class_id(@gym_class.id)
	erb(:"sessions/index")
end

post '/sessions' do
	new_session = Session.new(@params)
	new_session.create
	redirect to("/sessions/#{@params['gym_class_id']}/index")
end

post '/sessions/:session_id/:class_id/delete' do
	Session.delete_by_id(params['session_id'].to_i)
	redirect to("/sessions/#{params['class_id']}/index")
end
