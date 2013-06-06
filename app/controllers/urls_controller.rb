require 'debugger'
enable :sessions
set :session_secret, ENV["SESSION_KEY"]

post '/urls' do
  content_type :json
  url = Url.new(params[:url])
  if authenticated?
    url.user_id = current_user.id
  end
  if url.valid?
    url.save
    response = url
  else
    response = url.errors
  end
  response.to_json
end

get '/urls' do 
  content_type :json
  Url.all.reverse.to_json
end

get '/urls/:short_url' do
  shorten_url = params[:short_url]
  original = Url.find_by_shortened_url(shorten_url)
  Url.update_count(shorten_url)
  redirect "http://#{original.original_url}"
end

