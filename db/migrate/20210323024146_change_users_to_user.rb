class ChangeUsersToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_parties, :users_id, :user_id
  end
end
