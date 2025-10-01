class MoviesController < ApplicationController
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
<<<<<<< HEAD
    # for the Part 1 & 2 UI
    @all_ratings     = Movie.all_ratings
    @ratings_to_show = (params[:ratings]&.keys || @all_ratings)

    # Part 2: optional sort by title or release_date
    allowed = %w[title release_date]
    @sort_by = params[:sort_by].presence_in(allowed) || "title"

    # query: filter first, then sort (DB does the work)
    @movies = Movie.with_ratings(@ratings_to_show)
    @movies = @movies.order(@sort_by) if @sort_by.present?
=======
    @all_ratings     = Movie.all_ratings
    @ratings_to_show = (params[:ratings]&.keys || @all_ratings)
    @movies          = Movie.with_ratings(@ratings_to_show)
>>>>>>> heroku/master
  end
  

  def new; end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
