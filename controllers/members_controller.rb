require ('sinatra')

get '/members/' do
	erb(:"members/index")
