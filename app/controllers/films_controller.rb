class FilmsController < ApplicationController
  before_action :check_authentication, except: :index
  before_action :manager_permission, except: [:index, :show]
  before_action :set_film, only: [:show, :edit, :update, :destroy]


  def index
    @films = Film.includes(:genre).ordering.page(params[:page])
  end


  def show
  end

  def new
    @film = Film.new
  end

  def edit
  end


  def create
    @film = Film.new(film_params)
    if @film.save
      redirect_to @film, notice: 'Фильм создан.'
    else
      render :new
    end
  end


  def update
    if @film.update(film_params)
      redirect_to @film, notice: 'Фильм изменен.'
    else
      render :edit
    end
  end


  def destroy
    if @film.destroy
      redirect_to films_url, notice: 'Файл удален.'
    else
      flash[:danger]="Удаление фильма невозможно"
      redirect_to @film
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_film
    @film = Film.full.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def film_params
    params.require(:film).permit(:name, :origin_name, :slogan, :country_id, :genre_id, :director_id, :length, :year,
                                 :trailer_url, :cover, :description, :person_tokens)
  end


  def manager_permission
    render_error unless Film.manage?(@current_user)
  end
end
