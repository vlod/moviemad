namespace :mm do
  desc "Load movie data"
  task(:load_movie_data => :environment) do
    # lets cache these. map category_name -> category_id
    all_categories = Category.select([:name,:id]).all.inject({}) {|map, c| map[c.name] = c.id; map}

    ml = MovieLoader.new
    File.open("data-movie/movies.dat", 'r:iso8859-1').each_line do |line|
      ml << line
    end
  end
end