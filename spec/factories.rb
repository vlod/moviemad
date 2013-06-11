FactoryGirl.define do
  factory :moviedetails_toystory, class:MovieDetails do |md|
    movie_id  23
    runtime   "1 h 21 min"
    plot      "A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy's room."
    poster    "file://#{Rails.root}/public/movie_posters/eb/eb4d5a817c698b1d8d9e9b48ab51a245.jpg"
    imdbID    "tt0114709"
    released_at Time.parse("1995-11-22 00:00:00")
  end

  factory :movie_toystory, class:Movie do |m|
    id           23
    title        "Toy Story"
    title_md5    "eb4d5a817c698b1d8d9e9b48ab51a245"
    movielens_id 1
    released_at  Time.parse("1995-01-01 0:00 UTC")

    # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
    factory :toystory_movie_with_details do |md|
      after(:create) { FactoryGirl.create(:moviedetails_toystory) }
    end
  end
end