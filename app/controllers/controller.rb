get '/' do
  erb :index
end

before '/secret' do 
  redirect '/' unless logged_in?
end

get '/secret' do 
  erb :secret
end
