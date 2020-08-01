require('sinatra')
require_relative('./controllers/bookings_controller.rb')
require_relative('./controllers/members_controller.rb')
require_relative('./controllers/gym_classes_controller.rb')
require_relative('./controllers/sessions_controller.rb')

get '/' do
	erb(:index)
end
