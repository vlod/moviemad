class MoviesController < ApplicationController
  def index
    @category = Category.where(id:params[:category_id]).first
    @movies = @category.movies.order(:title).page(params[:page])
  end

  def show
    respond_to do |format|
      format.json do
        movie = Movie.where(id:params[:id]).includes(:movie_details).first

        result = Jbuilder.encode do |json|
          json.movie_id movie.id
          json.plot movie.movie_details.plot
          json.poster movie.title_md5
          json.poster_dir movie.title_md5[0..1]
        end

        render js:result
      end
    end
  end
end