require "#{Rails.root}/lib/utils.rb"
namespace :mm do
  desc "Load movie details"
  task(:load_movie_details => :environment) do
    imdb = IMDBLoader.new

    movies = Movie.select([:id,:title, :title_md5, :released_at]).where("title_md5 is NOT NULL").order(:id).all
    movies.each do |movie|
      imdb.load movie
    end
  end
end