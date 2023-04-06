class AddDescriptiveTitleToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :descriptivetitle, :string
  end
end
