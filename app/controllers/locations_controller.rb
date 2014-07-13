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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  def yelp_search
    consumer_key = 'DhEyrTa5xjjvWwAQiuhYuA'
    consumer_secret = 'ZqJe2cM11YUcUtZiM7Uhr5cEnM8'
    token = 'jE-067Nex2rCVb0QJqPNTiqcaBDWN390'
    token_secret = 'ee4Y9lDQ61KrMTPtnCkeMS1VFak'

    api_host = 'api.yelp.com'
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    path = "/v2/search?term=#{params[:term]}&ll=#{params[:ll]}&radius=1&limit=1"

    render json: access_token.get(URI.encode(path)).body.to_json
  end 

  def yelp_business
    # url = "http://www.yelp.com/biz/boa-steakhouse-west-hollywood"
    url = params[:url]
    agent = Mechanize.new
    doc = Nokogiri::HTML(agent.get(URI.encode(url)).body)
    render json: '[' + doc.css(".review-content").map { |review| '["' + 
                    review.css("meta[@itemprop='datePublished']").attr("content").text + '",' + 
                    review.css("meta[@itemprop='ratingValue']").attr("content").text + ']'}.join(', ') + ']'  
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
