class PeopleController < ApplicationController
  before_action :check_authentication, except: :index
  before_action :manager_permission, except: [:index, :show]
  before_action :set_person, only: [:show, :edit, :update, :destroy]


  def index
    respond_to do |format|
      format.html do
        @people = Person.ordering.page(params[:page])
      end
      format.json do
        @people = Person.search(params[:q]).all
        render json: @people
      end
    end


  end


  def show
  end


  def new
    @person = Person.new
  end

  def edit
  end


  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: 'Персона создана.'
    else
      render :new
    end
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Персона изменена.'
    else
      render :edit
    end
  end

  def destroy
    if @person.destroy
      redirect_to people_url, notice: 'Персона удалена.'
    else
      flash[:danger]='Удаление персоны невозможно'
      redirect_to @person
    end
  end

  private

  def set_person
    @person = Person.full.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :origin_name, :birthday, :avatar)
  end

  def manager_permission
    render_error unless Person.manage?(@current_user)
  end
end
