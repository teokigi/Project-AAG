require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/session.rb')
also_reload( '../models/*' )

get '/sessions/:class_id/index' do
	@class_id = params['class_id'].to_i
	@sessions = Session.find_sessions_with_gym_class_id(@class_id)
	erb(:"sessions/index")
end
