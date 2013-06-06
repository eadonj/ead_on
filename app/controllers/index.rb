enable :sessions
set :session_secret, ENV["SESSION_KEY"]

get '/' do
  erb :index
end

before '/secret' do 
  redirect '/' unless authenticated?
end

get '/secret' do 
  erb :secret
end


