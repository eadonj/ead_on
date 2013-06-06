
post '/users' do
  user = User.create(params[:user])
  redirect '/'
end

get '/users/new' do
  erb :signup
end

get '/users/:id' do
  erb :profile
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

get '/logout' do
  session.clear
  redirect '/'
end
