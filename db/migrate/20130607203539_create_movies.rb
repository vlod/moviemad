class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :movielens_id
      t.datetime :released_at
      t.timestamps
    end
    add_index :movies, :movielens_id
  end
end
