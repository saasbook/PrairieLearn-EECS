class ChangeDescriptionTypeInSelected < ActiveRecord::Migration[6.1]
  def change
    change_column :questions, :selected, :boolean
  end
end
