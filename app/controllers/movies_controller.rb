class MoviesController < ApplicationController
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
    # If params are given, update session
    if params[:ratings] || params[:sort_by]
      session[:ratings] = params[:ratings] if params[:ratings]
      session[:sort_by] = params[:sort_by] if params[:sort_by]
    end
  
    # If no params, fall back to session
    @ratings_to_show = if params[:ratings]
                         params[:ratings].keys
                       elsif session[:ratings]
                         session[:ratings].keys
                       else
                         Movie.all_ratings
                       end
  
    @sort_by = params[:sort_by] || session[:sort_by]
  
    # Always fetch the movies with remembered settings
    @all_ratings = Movie.all_ratings
    @movies = Movie.with_ratings(@ratings_to_show)
    @movies = @movies.order(@sort_by) if @sort_by.present?
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
