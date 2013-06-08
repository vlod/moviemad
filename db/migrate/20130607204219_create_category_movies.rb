class CreateCategoryMovies < ActiveRecord::Migration
  def change
    create_table :category_movies do |t|
      t.integer :category_id
      t.integer :movie_id

      t.timestamps
    end
    add_index :category_movies, [:category_id,:movie_id]
  end
end
