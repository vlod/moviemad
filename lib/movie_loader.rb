class MovieLoader
  attr_accessor :movielens_id, :movie_title, :categories, :movie_categories, :released_at
  def initialize
    @categories = {}  # category_name -> category_id
  end

  # e.g 1::Toy Story (1995)::Animation|Children's|Comedy
  def << line
    @movie_category_ids = Set.new

    @movielens_id, @movie_title, catgs = line.split("::")

    @released_at = @movie_title.match(/(\d{4})/)[1] # pull out the year 1995
    @movie_title.gsub! /\s\(\d{4}\)$/,'' # rip out the year

    catgs.strip.split("|").each do |category_name|
      category_id = @categories[category_name]

      if category_id # no need to add it
        @movie_category_ids.add category_id
        next
      end

      category = Category.create name:category_name
      @categories[category_name] = category.id

      @movie_category_ids.add category.id
    end

    # create it if we've not seen this movie before
    return if Movie.where(movielens_id:@movielens_id).first

    movie = Movie.create title:@movie_title, movielens_id:@movielens_id, released_at:Time.new(@released_at+"-01-01 00:00 UTC")

    @movie_category_ids.each do |category_id|
      CategoryMovie.create category_id:category_id, movie_id:movie.id
    end
  end
end