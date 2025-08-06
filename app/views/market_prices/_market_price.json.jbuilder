json.extract! market_price, :id, :product_name, :unit, :category, :location, :city, :date, :price, :created_at, :updated_at
json.url market_price_url(market_price, format: :json)
