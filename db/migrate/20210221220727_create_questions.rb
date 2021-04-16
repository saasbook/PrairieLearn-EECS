class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
   	  t.string :title
   	  t.string :user_id
   	  t.string :repo
    end
  end
end
