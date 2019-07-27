require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

enable :sessions
set :session_secret, "My session secret"

helpers do
  def current_user
    begin
      @current_user = session["user_nmae"]
        # @current_user = User.find(response.cookies["user_id"].to_i)
    rescue
      @current_user = nil
    end
  end
end

use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == 'foo' && password == 'bar'
end

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do

  session["user_id"] = 12345
  session["user_nmae"] = params[:username]

  p params[:username], params[:password]

  redirect '/'
end

get '/logout' do
  session.clear
  # response.set_cookie("user_id", value: "", expires: Time.now - 100 )
  redirect '/'
end