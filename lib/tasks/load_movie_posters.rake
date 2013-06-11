require "#{Rails.root}/lib/utils.rb"
namespace :mm do
  desc "Load movie posters"
  task(:load_movie_posters => :environment) do
    imdb = IMDBLoader.new

    movies = Movie.select([:id,:title,:title_md5]).where("title_md5 is not NULL").includes(:movie_details).order(:id).all
    movies.each do |movie|
      result = imdb.fetch_poster movie
      # sleep 3
    end
  end
end