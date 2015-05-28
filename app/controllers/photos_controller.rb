class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_album, only: :new

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = @album.photos.build
    @photo.album=@album
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @first = 0
    @album = Album.find(@photo.album_id)
    if params[:photo][:object].blank?
      flash[:danger]="При сохранении произошла ошибка! Необходимо загрузить хотя бы одну фотографию!"
      render :new
    else
      params[:photo][:object].each do |upload|
        @photo = Photo.new(photo_params)
        @photo.object=upload
        if @photo.album.photos.size==0
          @photo.position=@photo.id
          @first=@photo
        end
        if !@photo.save
          render :new
        end
        if @photo.position==1
          if Photo.where(id: @album.cover).load.map{|x| x}.size==1
            p1=Photo.where(id: @album.cover).load.map{|x| x}[0]
            p1.position=0
            p1.save
          end
          @photo.position=@photo.id
          @album.cover=@photo.id
          @album.save!
          @photo.save
        else
          @photo.position=0
        end
      end
      if @first!=0
        @album.cover=@first.id
        @album.save!
      end
      redirect_to @photo.album, notice: 'Фотографии загружены.'
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        if @photo.position!=0
          @album=@photo.album
          if Photo.where(id: @album.cover).load.map{|x| x}.size==1
            p1=Photo.where(id: @album.cover).load.map{|x| x}[0]
            p1.position=0
            p1.save
          end
          @album.cover=@photo.id
          @album.save!
        end
        format.html { redirect_to @photo, notice: 'Фотография изменена.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    alb=@photo.album
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to alb, notice: 'Фотография удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_album
      @album=Album.find(params[:album_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :title, :object, :position)
    end
end
