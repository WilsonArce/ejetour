class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    region = Region.find(params[:region_id])
    @places = region.places
    respond_to do |format|
      format.html
      format.xml { render :xml => @places}
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    region = Region.find(params[:region_id])
    @places = region.places.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @places}
    end
    @place_articles ||= []
    @articles = Article.all
    @articles.each do |article|
      if article.location == @place.nombre
        @place_articles.push(article)
      end
    end
  end

  # GET /places/new
  def new
    region = Region.find(params[:region_id])
    @place = region.places.build
    respond_to do |format|
      format.html
      format.xml { render :xml => @places}
    end
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    region = Region.find(params[:region_id])
    #@place = region.places.create(params[:place])
    @place = region.places.create(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to [@place.region, @place], notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update

    region = Region.find(params[:region_id])
    @place = region.places.find(params[:id])

    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to [@place.region, @place], notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    region = Region.find(params[:region_id])
    @place = region.places.find(params[:id])
    @place.destroy
    respond_to do |format|
      format.html { redirect_to region_places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:nombre, :descripcion, :imagen)
    end
end
