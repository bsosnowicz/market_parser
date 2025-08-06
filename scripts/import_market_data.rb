require 'json'
require_relative "../config/environment"

file_path = File.expand_path("../../js_scraper/data.json", __FILE__)

begin
  json_array = JSON.parse(File.read(file_path))
  json_array.each_with_index do |item, i|
    price_str = item['price'].to_s
    unit = price_str[/[a-zA-Z\/]+$/]

    unit = unit.split('/').last if unit&.include?('/')

    market_price = MarketPrice.new(
      product_name: item['product_name'],
      location: item['location'],
      city: item['city'],
      date: Date.parse(item['date']),
      price: item['price'].to_d,
      unit: unit
    )

    if market_price.save
      puts "Record #{i + 1} saved successfully."
    else
      puts "Error saving record #{i + 1}: #{market_price.errors.full_messages.join(', ')}"
    end
  end
end
