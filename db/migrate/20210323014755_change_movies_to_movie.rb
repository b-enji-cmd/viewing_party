class ChangeMoviesToMovie < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :movies_id, :movie_id
  end
end
