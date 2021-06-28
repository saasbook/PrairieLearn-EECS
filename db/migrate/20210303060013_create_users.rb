class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.string :username
      t.string :provider
      t.string :token
      t.string :repo
    end
    add_index :users, :uid, unique: true
  end
end
