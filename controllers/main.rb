before do
  @flickr = FlickRaw::Flickr.new

  unless session[:access_token].nil?
    @flickr.access_token = session[:access_token]
    @flickr.access_secret = session[:access_token_secret]
  end
end

get '/?' do
  erb :index
end

get '/me' do
  begin
    login = @flickr.auth.checkToken
    puts "You are authenticated as #{login.username}"
    @username = login.username
    erb :me
  rescue FlickRaw::FailedResponse => e
    puts "Authentication Failed : #{e.msg}"
    redirect '/'
  end
end
