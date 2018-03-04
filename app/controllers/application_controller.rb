require './config/environment'

class ApplicationController < Sinatra::Base
  require 'rack-flash'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end

  get '/' do 
   if logged_in?
      @user = User.find(current_user.id)
      erb :"/stacks/stacks"
    else
  	  erb :index
    end
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		@user = User.find_by_id(session[:user_id])
  	end

    def logout!
      session.clear
      redirect to '/'
    end
  end

end
