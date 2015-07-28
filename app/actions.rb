# Homepage (Root path)
enable :sessions

before '/*' do
  unless request.path == '/signups/new' ||
    request.path == '/logins/index'
    if !session[:username]
      redirect '/logins/index' 
    end
  end
end

get '/' do
  erb :index
end

get '/songs' do
  @song = Song.select('songs.*, COUNT(likes.id)').joins('LEFT JOIN likes ON songs.id = likes.song_id GROUP BY songs.id ORDER BY COUNT(likes.id) DESC')
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/signups/new' do
  erb :'signups/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  @reviews = @song.reviews
  @new_review = Review.new
  erb :'songs/show'

end

post '/review' do
  @new_review = Review.new(
    song_id: params[:song_id],
    username: session[:username],
    review: params[:review])
  if @new_review.save
    redirect "/songs/#{@new_review.song_id}"
  end
  end

post '/signups/new' do
  @user = User.new(
    username: params[:username],
    password: params[:password],
    name: params[:name]
    )
  if @user.save
    redirect '/logins/index'
  else
    erb :'signups/new'
  end
end

get '/logins/index' do
  erb :'logins/index'
end

post '/logins/index' do
  # request.logger.info params
  if User.authenticate_user(params[:username],params[:password])
    session[:username] = params[:username]
    redirect '/songs'
  else
    erb :'logins/index'
  end
end

get '/logout' do
  session[:username] = nil
  redirect '/logins/index'
end

post '/like' do 
  @like = Like.new(song_id: params[:song_id],user_id: session[:username])
  if @like.save
    redirect '/songs'
  end
end

post '/delete' do
  @review = Review.find (
    params[:review_id]
    )
    @review.destroy
    redirect "/songs/#{@review.song_id}"
  end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: session[:username]
    )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end
