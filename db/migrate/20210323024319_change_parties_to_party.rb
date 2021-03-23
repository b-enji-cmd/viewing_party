class ChangePartiesToParty < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_parties, :parties_id, :party_id
  end
end
