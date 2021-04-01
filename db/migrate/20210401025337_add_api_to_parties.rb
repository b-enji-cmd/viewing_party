class AddApiToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :api_id, :integer
  end
end
