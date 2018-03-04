class StacksController < ApplicationController 

	get '/stacks' do
		if logged_in?
			@user = User.find(current_user.id)
			erb :"/stacks"
		else
			redirect to "/login"
		end
	end

	get '/stacks/new' do
		if logged_in?
			@user = User.find(current_user.id)
			erb :"stacks/new"
		else
			redirect to "/login"
		end
	end

	post '/stacks' do
		if params[:title] == "" || params[:subject] == ""
			redirect to "/stacks/new"
		else
			@user = User.find(current_user.id)
			@stack = Stack.create(:title => params[:title], :subject => params[:subject])
			@user.stacks << @stack
			redirect to "/stacks/#{@stack.id}"
		end
	end

	get '/stacks/:id' do
		if logged_in?
			@stack = Stack.find(params[:id])
			erb :"stacks/show"
		else
			redirect to "/login"
		end
	end

	get '/stacks/:id/edit' do
		if logged_in?
			@user = User.find(current_user.id)
			@stack = Stack.find(params[:id])
			if @stack.user_id == current_user.id # make sure that the only person who could edit is the one who created the stack
				erb :"stacks/edit"
			else
				redirect to "/stacks"
			end
		else
			redirect to "/login"
		end
	end

	patch '/stacks/:id' do
		@stack = Stack.find_by_id(params[:id])
		if params[:title] == "" || params[:subject] == ""
			redirect to "/stacks/#{params[:id]}/edit"
		else
			@stack.title = params[:title]
			@stack.subject = params[:subject]
			@stack.save
			redirect to "/stacks/#{params[:id]}"
		end
	end

	post '/stacks/:id/delete' do
		stack = stack.find(params[:id])
		if stack.user_id == current_user.id
			stack.delete
			stack.save
			redirect to "/stacks"
		else
			redirect to "/stacks"
		end
	end



end