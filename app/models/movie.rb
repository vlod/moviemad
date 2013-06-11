class Movie < ActiveRecord::Base
  attr_accessible :title, :movielens_id, :released_at, :title_md5
  attr_accessor :details_directoy_name
  include Utils

  has_many :category_movies
  has_many :categories, :through=>:category_movies
  has_one :movie_details

  paginates_per 20

  def title_as_md5
    self.class.md5 self.title
  end

  def directory_name
    self.details_directoy_name = title_as_md5[0..1]
  end

  def details_filename
    directory_name

    output_fname = ["#{self.details_directoy_name}/"]
    output_fname << "test_" if Rails.env == 'test'
    output_fname << "#{title_as_md5}.json"
    output_fname.join
  end

  def poster_filename
    directory_name

    output_fname = ["#{self.details_directoy_name}/"]
    output_fname << "#{title_as_md5}.jpg"
    output_fname.join
  end
end
