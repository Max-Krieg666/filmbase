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
    params[:photo][:object].each do |upload|
      @photo = Photo.new(photo_params)
      @photo.object=upload
      if @photo.album.photos.size==0
        @photo.position=1
      else
        @photo.position=0
      end
      if !@photo.save
         render :new
      end
    end
    redirect_to @photo.album, notice: 'Фотографии загружены.'
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        if @photo.position!=0
          @album=@photo.album
          if Photo.where(id: @album.cover).load.map{|x| x}.size>0
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
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Фотография удалена.' }
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
