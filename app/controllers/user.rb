
post '/users' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect '/'
end

get '/users/new' do
  erb :signup
end

get '/users/:id' do
  erb :profile
end

post '/users/edit' do
  p params[:id]
  user = User.find(params[:id])
  user.update_attributes(params[:user])
  user.save
  redirect '/#response'
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by_email(params[:user][:email])
  if User.authenticate(params[:user])
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
