class FlashcardsController < ApplicationController 

	get '/flashcards' do
		erb :"/flashcards/flashcards"
	end

	get '/flashcards/new' do
		if logged_in?
			@user = User.find(current_user.id)
			erb :"flashcards/new"
		else
			redirect to "/login"
		end
	end

	post '/flashcards' do
		if params[:question] == "" || params[:answer] == ""
			redirect to "/flashcards/new"
		else
			@user = User.find(current_user.id)
			@flashcard = Flashcard.create(:question => params[:question], :answer => params[:answer])
			@user.flashcards << @flashcard
			redirect to "/flashcards/#{@flashcard.id}"
		end
	end

	get '/flashcards/:id' do
		if logged_in?
			@flashcard = Flashcard.find(params[:id])
			erb :"flashcards/show"
		else
			redirect to "/login"
		end
	end

	get '/flashcards/:id/edit' do
		if logged_in?
			@user = User.find(current_user.id)
			@flashcard = Flashcard.find(params[:id])
			if @flashcard.user_id == current_user.id # make sure that the only person who could edit is the one who created the flashcard
				erb :"flashcards/edit"
			else
				redirect to "/flashcards"
			end
		else
			redirect to "/login"
		end
	end

	patch '/flashcards/:id' do
		@flashcard = Flashcard.find_by_id(params[:id])
		if params[:question] == "" || params[:answer] == ""
			redirect to "/flashcards/#{params[:id]}/edit"
		else
			@flashcard.question = params[:question]
			@flashcard.answer = params[:answer]
			@flashcard.save
			redirect to "/flashcards/#{params[:id]}"
		end
	end

	post '/flashcards/:id/delete' do
		flashcard = flashcard.find(params[:id])
		if flashcard.user_id == current_user.id
			flashcard.delete
			flashcard.save
			redirect to "/flashcards"
		else
			redirect to "/flashcards"
		end
	end



end