class AddSelectedToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :selected, :string
  end
end
