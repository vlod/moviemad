class CategoryMovie < ActiveRecord::Base
  attr_accessible :category_id, :movie_id
  belongs_to :category
  belongs_to :movie
end
