def authenticated?
  if session[:user_id]
    return true if User.find(session[:user_id])
  end
  false
end
