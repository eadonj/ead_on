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

get '/:short_url' do
  shorten_url = params[:short_url]
  # original = Url.where('shortened_url = ?', shorten_url )
  original = Url.find_by_shortened_url(shorten_url)
  # redirect "http://#{original[0].original_url}"
  Url.update_count(shorten_url)
  redirect "http://#{original.original_url}"
end
