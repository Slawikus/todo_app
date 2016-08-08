class AddIndexToUsersToken < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :token, unique: true
  end
end
