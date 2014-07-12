class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.order("id desc").page(params[:page]).per(50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  def new
    @location = Location.new

    consumer_key = 'DhEyrTa5xjjvWwAQiuhYuA'
    consumer_secret = 'ZqJe2cM11YUcUtZiM7Uhr5cEnM8'
    token = 'jE-067Nex2rCVb0QJqPNTiqcaBDWN390'
    token_secret = 'ee4Y9lDQ61KrMTPtnCkeMS1VFak'

    api_host = 'api.yelp.com'
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    path = "/v2/search?term=boa&ll=34.089762,-118.39279199999999&radius=1&limit=1"

    @yelp = access_token.get(path).body.to_json


    # doc = Nokogiri::HTML(open())
    site = "http://www.yelp.com/biz/boa-steakhouse-west-hollywood"
    # site = 'http://www.thatvenue.com/'
    # doc = Nokogiri::HTML(open(site, 'User-Agent' => 'ruby'))

    doc = Nokogiri::HTML(open(site))

    # url_text = Net::HTTP.get(URI.parse site)
    # doc = Nokogiri::XML(url_text)
    # @result = doc.css('#super-container').text.to_json


    # @resultHash = {}
    # .star-img
    # doc.css('#search-box').each do |content|
    #   @result = content.to_json
    # end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location = Location.find(params[:id])
    
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params[:location]
    end
end
