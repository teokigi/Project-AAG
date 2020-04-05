require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/members.rb')
also_reload( '../models/*' )

get '/members' do
	# @members = Members.find_all
	erb(:"members/index")
end
