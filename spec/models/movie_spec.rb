require 'spec_helper'

describe Movie do
  it "should return correct movie details filename" do
    movie = FactoryGirl.create :movie_toystory
    movie.should_not == nil
    movie.details_filename.should == "eb/test_eb4d5a817c698b1d8d9e9b48ab51a245.json"
    movie.details_directoy_name.should == "eb"
  end
end