class MovieTitleMd5 < ActiveRecord::Migration
  def up
    add_column :movies, :title_md5, :string
    add_index :movies, :title_md5
  end

  def down
    remove_column :movies, :title_md5
  end
end
