class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :category_movies
  has_many :movies, :through=>:category_movies
end
