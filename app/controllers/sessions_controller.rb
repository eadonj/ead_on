get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:user][:email])
  if User.authenticate(params[:user][:email], params[:user][:password])
    session[:user_id] = @user.id
    erb :profile
  end
  erb :login
end

get '/logout' do
  session.clear
  erb :index
end
