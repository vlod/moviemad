require 'spec_helper'

describe MoviesController do
  it "should get movie details in json format" do
    movie = FactoryGirl.create :toystory_movie_with_details
    movie.id.should == 23
    movie.movie_details.imdbID.should == "tt0114709"

    get :show, {id:"23.json" , :format => :json}
    results = JSON.parse response.body
    # puts "response body:[#{results}]"
    results["movie_id"].should == 23
    results["plot"].should  == "A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy's room."
    results["poster"].should == "eb4d5a817c698b1d8d9e9b48ab51a245"
    results["poster_dir"].should == "eb"
  end
end