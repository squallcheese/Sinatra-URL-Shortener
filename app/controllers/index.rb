#require_relative "../app/models/Url"

get '/' do
 # let user create new short URL, display a list of shortened URLs
  if params[:url_input] && params[:url_input].empty?
      generate_short_url(params[:url_input])
  else
      @short_url = Url.all
  erb :index
  end
end

post '/urls' do
  # create a new Url
  url = params[:url]
  created_link = Url.create(long_url: url)
  created_link.save!
  @short_url = Url.all

  if params[:url_input] && params[:url_input].empty?
      generate_short_url(params[:url_input])
  end
  erb :index
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
redirect = Url.find_by_short_url(params[:short_url])
redirect.click_count += 1
redirect.save

redirect.long_url

  erb :index
end
