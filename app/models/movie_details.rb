class MovieDetails < ActiveRecord::Base
  attr_accessible :imdbID, :movie_id, :plot, :poster, :released_at, :runtime
  belongs_to :movie
end
