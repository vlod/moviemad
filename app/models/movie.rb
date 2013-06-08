class Movie < ActiveRecord::Base
  attr_accessible :title, :movielens_id, :released_at
  paginates_per 20
  has_many :category_movies
  has_many :categories, :through=>:category_movies
end
