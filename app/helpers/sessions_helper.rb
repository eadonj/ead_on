def current_user
  if session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
end

def authenticated?
  !current_user.nil?
end

def log_in_user(user)
  session[:user_id] = user.id
end