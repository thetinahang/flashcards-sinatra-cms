require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "clandestine"
  end

  get '/' do # controller action to load home page

#    if logged_in?
#      @user = User.find(current_user.id)
#      redirect to "/stacks"
#    else
  	  erb :'/index' # index to link to login and signup
#    end
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
