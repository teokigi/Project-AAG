require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/member.rb')
also_reload( '../models/*' )

get '/members' do
	@members = Member.find_all
	erb( :"members/index" )
end

post '/members' do
	new_member = Member.new(params)
	new_member.create
	redirect to("/members")
end

post '/members/:member_id/delete' do
	Member.delete_by_id(id)
	redirect to("/members")
end
