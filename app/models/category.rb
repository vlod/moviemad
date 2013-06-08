class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :category_movies
  has_many :movies, :through=>:category_movies

  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
