require 'spec_helper'

describe MovieLoader do
  # 1::Toy Story (1995)::Animation|Children's|Comedy
  # 2::Jumanji (1995)::Adventure|Children's|Fantasy
  # 3::Grumpier Old Men (1995)::Comedy|Romance
  # 4::Waiting to Exhale (1995)::Comedy|Drama
  it "should save a movie" do
    ml = MovieLoader.new
    ml.categories.size == 0

    ml << "1::Toy Story (1995)::Animation|Children's|Comedy"

    ml.movie_title.should == "Toy Story"
    ml.movielens_id.should == "1"
    ml.released_at.should == "1995"
    ml.categories.size.should == 3

    Movie.count.should == 1
    movie = Movie.where(movielens_id:1).first
    movie.title.should == "Toy Story"
    movie.released_at.should === Time.new("1995-01-01 00:00 UTC")
    movie.movielens_id.should == 1

    # 3 categorys should be setup: Animation|Children's|Comedy
    ml.categories.size.should == 3
    all_categories = Category.select(:name).all.inject({}) {|map, c| map[c.name] = true; map}
    all_categories.size.should == 3
    all_categories.has_key?("Animation").should == true
    all_categories.has_key?("Children's").should == true
    all_categories.has_key?("Comedy").should == true

    ml << "2::Jumanji (1995)::Adventure|Children's|Fantasy"
    Movie.count.should == 2
    movie = Movie.where(movielens_id:2).first
    movie.title.should == "Jumanji"
    movie.movielens_id.should == 2

    # we've added Adventure and Fantasy. N.B Children's was already there
    ml.categories.size.should == 5
    all_categories = Category.select(:name).all.inject({}) {|map, c| map[c.name] = true; map}
    all_categories.size.should == 5
    all_categories.has_key?("Adventure").should == true
    all_categories.has_key?("Fantasy").should == true
  end

  it "should handle adding the same movie multiple times" do
    Movie.count.should == 0
    ml = MovieLoader.new
    ml << "1::Toy Story (1995)::Animation|Children's|Comedy"
    Movie.count.should == 1

    ml << "2::Jumanji (1995)::Adventure|Children's|Fantasy"
    Movie.count.should == 2

    ml << "1::Toy Story (1995)::Animation|Children's|Comedy"
    Movie.count.should == 2
  end

  it "should have correct association between category and movie" do
    ml = MovieLoader.new
    ml << "1::Toy Story (1995)::Animation|Children's|Comedy"
    ml << "2::Jumanji (1995)::Adventure|Children's|Fantasy"
    ml << "3::Grumpier Old Men (1995)::Comedy|Romance"
    ml << "4::Waiting to Exhale (1995)::Comedy|Drama"

    Movie.count.should == 4
    Category.count.should == 7

    category = Category.where(name:'Comedy').first
    category_movies = category.movies
    category_movies.size.should == 3

    # should have all the correct movies
    movies = category.movies.inject({}) {|map,m| map[m.title]=true; map}
    movies.has_key?('Toy Story').should == true
    movies.has_key?('Jumanji').should_not == true
    movies.has_key?('Grumpier Old Men').should == true
    movies.has_key?('Waiting to Exhale').should == true

    # check the movie has the right categories set
    movie = Movie.where(movielens_id:1).first
    movie_categories = movie.categories
    movie_categories.size.should == 3
    categories = movie.categories.inject({}) {|map,c| map[c.name]=true; map}
    categories.has_key?("Animation").should == true
    categories.has_key?("Children's").should == true
    categories.has_key?("Comedy").should == true
    categories.has_key?("Fantasy").should_not == true
  end
end
