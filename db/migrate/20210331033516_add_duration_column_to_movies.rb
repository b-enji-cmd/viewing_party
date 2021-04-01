class AddDurationColumnToMovies < ActiveRecord::Migration[5.2]
  def change
  	add_column :movies, :duration, :integer
  end
end
