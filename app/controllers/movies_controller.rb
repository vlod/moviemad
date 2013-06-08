class MoviesController < ApplicationController
  def index
    @category = Category.where(id:params[:category_id]).first
    @movies = @category.movies.order(:title).page(params[:page])
  end
end