class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  before_action :check_authentication, except: :index
  before_action :manager_permission, except: [:index, :show]


  def index
    @genres = Genre.ordering.page(params[:page])
  end


  def show
    @films=@genre.films.page(params[:page])
  end


  def new
    @genre = Genre.new
  end

  def edit
  end


  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: 'Жанр создан'
    else
      render :new
    end
  end


  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: 'Жанр изменен.'
    else
      render :edit
    end
  end


  def destroy
    if @genre.destroy
      redirect_to genres_path, notice: 'Жанр удален'
    else
      flash[:danger]='Удаление жанра невозможно'
      redirect_to @genre
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end


  def genre_params
    params.require(:genre).permit(:name)
  end

  def manager_permission
    render_error unless Genre.manage?(@current_user)
  end
end
