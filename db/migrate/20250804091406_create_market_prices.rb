class CreateMarketPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :market_prices do |t|
      t.string :product_name
      t.string :unit
      t.string :category
      t.string :location
      t.string :city
      t.date :date
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
