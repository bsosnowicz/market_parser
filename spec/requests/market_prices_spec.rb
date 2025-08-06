require 'swagger_helper'

RSpec.describe 'market_prices API', type: :request do
  path '/market_prices' do
    get('list market_prices') do
      tags 'Market Prices'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   product_name: { type: :string },
                   location: { type: :string },
                   city: { type: :string },
                   average_price: { type: :number },
                   unit: { type: :string, nullable: true },
                   date: { type: :string, format: :date }
                 },
                 required: ['id', 'product_name', 'location', 'city', 'average_price', 'date']
               }

        run_test!
      end
    end
  end
end