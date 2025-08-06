class MarketPricesController < ApplicationController
  before_action :set_market_price, only: %i[ show edit update destroy ]

  # GET /market_prices or /market_prices.json
  def index
    @market_prices = MarketPrice.all

    @market_prices = @market_prices.where(product_name: params[:product_name]) if params[:product_name].present?
    @market_prices = @market_prices.where(location: params[:location]) if params[:location].present?

    respond_to do |format|
      format.html
      format.json { render json: @market_prices }
    end
  end

  # GET /market_prices/1 or /market_prices/1.json
  def show
  end

  # GET /market_prices/new
  def new
    @market_price = MarketPrice.new
  end

  # GET /market_prices/1/edit
  def edit
  end

  # POST /market_prices or /market_prices.json
  def create
    @market_price = MarketPrice.new(market_price_params)

    respond_to do |format|
      if @market_price.save
        format.html { redirect_to @market_price, notice: "Market price was successfully created." }
        format.json { render :show, status: :created, location: @market_price }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @market_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market_prices/1 or /market_prices/1.json
  def update
    respond_to do |format|
      if @market_price.update(market_price_params)
        format.html { redirect_to @market_price, notice: "Market price was successfully updated." }
        format.json { render :show, status: :ok, location: @market_price }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @market_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market_prices/1 or /market_prices/1.json
  def destroy
    @market_price.destroy!

    respond_to do |format|
      format.html { redirect_to market_prices_path, status: :see_other, notice: "Market price was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_price
      @market_price = MarketPrice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def market_price_params
      params.require(:market_price).permit(:product_name, :unit, :category, :location, :city, :date,:price)
    end
end
