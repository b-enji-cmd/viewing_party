class RenameMovieTitleToMovieId < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :movie_title, :movie_id
  end
end
