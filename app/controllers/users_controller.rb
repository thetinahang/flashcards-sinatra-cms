class UsersController < ApplicationController 
	get '/signup' do 
		if logged_in? 
			redirect to "/stacks"
		else
			erb :"users/new"
		end 
	end

	post '/signup' do 
		if params[:username] == "" || params[:email] == "" || params[:password] == ""
			redirect to '/signup'
		else
			user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
			user.save
			session[:user_id] = user.user_id
			redirect to '/users/show'
		end	
	end

	get '/login' do
		if logged_in?
			redirect to "/users/show"
		else
			redirect to "/signup"
		end
	end

	post '/login' do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.user_id
			redirect to "/users/show"
		else
			redirect to "/"
		end
	end

	get '/logout' do
		if logged_in?
			session.clear
			redirect to "/login"
		else
			redirect to "/"
		end
	end

end