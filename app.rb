require('sinatra')
require('sinatra/contrib/all')

get '/' do
	erb(:index)
end
