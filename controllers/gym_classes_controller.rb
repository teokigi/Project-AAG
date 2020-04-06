require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/gym_class.rb')

get '/gym_classes' do
	@classes = GymClass.find_all
	@sessions = Session.find_all
	erb(:"gym_classes/index")
end

post '/gym_classes' do
	new_class = GymClass.new(params)
	new_class.create
	redirect to("/gym_classes")
end

post '/gym_classes/:class_id/delete' do
	GymClass.delete_by_id(params['class_id'].to_i)
	redirect to("/gym_classes")
end

post '/gym_classes/:class_id/toggle' do
	toggling_class = GymClass.find_by_id(@params['class_id'].to_i)
	toggling_class.toggle_status
	redirect to("/gym_classes")
end
