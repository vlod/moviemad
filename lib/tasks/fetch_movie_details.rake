require "#{Rails.root}/lib/utils.rb"
namespace :mm do
  desc "Fetch movie details"
  task(:fetch_movie_details => :environment) do
    imdb = IMDBLoader.new

    movies = Movie.select([:id,:title, :title_md5, :released_at]).where("title_md5 is NULL").order(:id).all
    movies.each do |movie|
      imdb.fetch movie
    end
  end
end