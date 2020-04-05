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
	Member.delete_by_id(@params['member_id'].to_i)
	redirect to("/members")
end

post '/members/:member_id/toggle' do
	member = Member.find_by_id(@params['member_id'].to_i)
	member.toggle_status
	redirect to("/members")
end
