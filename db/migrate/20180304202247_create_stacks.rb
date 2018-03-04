class CreateStacks < ActiveRecord::Migration[5.1]
  def change
  	create_table :stacks do |t|
  		t.string :title
  		t.string :subject
  		t.integer :user_id
  	end 
  end
end
