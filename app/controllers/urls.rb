
post '/urls' do
  content_type :json
  url = Url.new(params[:url])
  if url.valid?
    url = Url.create(params[:url])
    url.user = current_user if current_user
    url.save
  else
    url = "This is an error message"
  end
  url.to_json
end

get '/urls/:short_url' do
  shorten_url = params[:short_url]
  original = Url.find_by_shortened_url(shorten_url)
  p original
  original.update_count
  redirect "http://#{original.original_url}"
end
