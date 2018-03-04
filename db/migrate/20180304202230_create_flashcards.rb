class CreateFlashcards < ActiveRecord::Migration[5.1]
  def change
  	create_table :flashcards do |t|
  		t.string :question
  		t.string :answer
  		t.integer :stack_id
  	end 
  end
end
