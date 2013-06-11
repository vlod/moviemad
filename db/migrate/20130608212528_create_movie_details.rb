class CreateMovieDetails < ActiveRecord::Migration
  def change
    create_table :movie_details do |t|
      t.integer :movie_id
      t.datetime :released_at
      t.string :runtime
      t.string :plot
      t.string :poster
      t.string :imdbID

      t.timestamps
    end
    add_index :movie_details, :movie_id
  end
end
