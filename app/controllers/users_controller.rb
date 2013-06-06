post '/users' do
  user = User.create(params[:user])
  if User.authenticate(user.email, user.password)
    log_in_user(user)
    erb :secret
  end
  redirect '/'
end

get '/users/new' do
  erb :signup
end

before '/users/:id' do 
  unless authenticated?
    redirect '/'
    @message = "You must be logged in to access that page"
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :profile
end