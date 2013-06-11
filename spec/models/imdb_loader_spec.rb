require 'spec_helper'

describe IMDBLoader do
  it "should load movie details" do
    movie = Movie.create title:"Toy Story", released_at:Time.new("1995-01-01 00:00 UTC"),
                            title_md5:"test_eb4d5a817c698b1d8d9e9b48ab51a245.json"
    movie.title_as_md5.should == "eb4d5a817c698b1d8d9e9b48ab51a245"
    # copy over the sample json file
    FileUtils.cp "#{Rails.root}/spec/data/test_eb4d5a817c698b1d8d9e9b48ab51a245.json", "#{Rails.root}/data/movie_details/eb/"

    imdb = IMDBLoader.new
    result = imdb.load movie
    result.should == true


    md = MovieDetails.where(movie_id:movie.id).first
    md.should_not == nil
    md.released_at.should == "22 Nov 1995"
    md.runtime       == "1 h 21 min"
    md.plot.should   == "A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy's room."
    md.poster.should == "http://ia.media-imdb.com/images/M/MV5BMTgwMjI4MzU5N15BMl5BanBnXkFtZTcwMTMyNTk3OA@@._V1_SX200.jpg" # we dont need the large image
    md.imdbID.should == "tt0114709"

    File.delete "#{Rails.root}/data/movie_details/eb/test_eb4d5a817c698b1d8d9e9b48ab51a245.json"
  end

  it "should blank out N/A during load movie_details" do
    movie = Movie.create title:"A Boy Called Hate", released_at:Time.new("1995-01-01 00:00 UTC")
    FileUtils.cp "#{Rails.root}/spec/data/test_d814369ee8e5299b511911c6f7269f49.json", "#{Rails.root}/data/movie_details/d8/"

    imdb = IMDBLoader.new
    result = imdb.load movie
  end

  it "should save the movie_details correctly" do
    movie = Movie.create title:"Toy Story", released_at:Time.new("1995-01-01 00:00 UTC")
    output_fname = IMDBLoader::BASE_DETAILS_DIR+movie.details_filename
    File.delete(output_fname) if File.exists?(output_fname) # just in case

    imdb = IMDBLoader.new
    imdb.base_url = "file://#{Rails.root}/spec/data/omdb_api_good.html"
    result = imdb.fetch movie
    result.should == true

    # it should have created a file
    File.exists?(output_fname).should == true
    File.stat(output_fname).size.should_not == 0

    # make sure the file is saved okay
    results = JSON.parse IO.read(output_fname)
    results["Title"].should == "Toy Story"

    # should have updated title_md5
    movie.reload
    movie.title_md5.should == "eb4d5a817c698b1d8d9e9b48ab51a245"

    # if we try and get it again, it should return false (as we already have it)
    movie.update_attribute :title_md5, nil
    result = imdb.fetch movie
    result.should == false

    # should set this, even to indicate theres a file present
    movie.title_md5.should == "eb4d5a817c698b1d8d9e9b48ab51a245"
    File.delete output_fname
  end

  it "should download movie poster files" do
    movie = Movie.create title:"Toy Story", released_at:Time.new("1995-01-01 00:00 UTC"),
                        title_md5:"test_eb4d5a817c698b1d8d9e9b48ab51a245.json"
    output_fname = IMDBLoader::BASE_POSTER_DIR+movie.poster_filename
    imdb = IMDBLoader.new
    imdb.base_url = "file://#{Rails.root}/spec/data/omdb_api_good.html"
    result = imdb.fetch_poster movie

    File.exists?(output_fname).should == true
  end

end