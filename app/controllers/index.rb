require_relative '../helpers/sessions_helper.rb'

enable :sessions
set :session_secret, ENV["SESSION_KEY"]

get '/' do
  erb :index
end

post '/urls' do
  content_type :json
  url = Url.new(params[:url])
  if url.valid?
    response = Url.create(params[:url])
  else
    response = "This is an error message"
  end
  puts "response: #{response}"
  response.to_json
end

get '/urls/:short_url' do
  shorten_url = params[:short_url]
  original = Url.find_by_shortened_url(shorten_url)
  Url.update_count(shorten_url)
  redirect "http://#{original.original_url}"
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by_email(params[:user][:email])
  if User.authenticate(params[:user][:email], params[:user][:password])
    session[:user_id] = user.id
    redirect '/secret'
  else
    redirect '/'
  end
end

post '/users' do
  user = User.create(params[:user])
  redirect '/'
end

post '/logout' do
  session.clear
  redirect '/'
end

get '/users/new' do
  erb :signup
end

get '/users/:id' do
  erb :profile
end

before '/secret' do 
  redirect '/' unless authenticated?
end

get '/secret' do 
  erb :secret
end


