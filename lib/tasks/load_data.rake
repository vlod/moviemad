namespace :mm do
  desc "Load movie data"
  task(:load_movie_data => :environment) do
    ml = MovieLoader.new
    File.open("data-movie/movies.dat", 'r:iso8859-1').each_line do |line|
      ml << line
    end
  end
end