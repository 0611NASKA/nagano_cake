class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "You have created genre successfully."
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def edit
  end 

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
