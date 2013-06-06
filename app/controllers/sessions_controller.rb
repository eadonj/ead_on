get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:user][:email])
  if User.authenticate(params[:user][:email], params[:user][:password])
    session[:user_id] = @user.id
    @message = "Welcome back!"
    erb :profile
  else
    @message = "Sorry please try again"
    erb :login
  end
end

get '/logout' do
  session.clear
  @message = "You've been successfully logged out"
  erb :index
end
