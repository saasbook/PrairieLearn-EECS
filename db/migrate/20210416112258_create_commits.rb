class CreateCommits < ActiveRecord::Migration[6.1]
  def change
    create_table :commits do |t|
      t.string :sha
      t.string :repo
    end
  end
end
