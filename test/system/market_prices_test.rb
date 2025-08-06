require "application_system_test_case"

class MarketPricesTest < ApplicationSystemTestCase
  setup do
    @market_price = market_prices(:one)
  end

  test "visiting the index" do
    visit market_prices_url
    assert_selector "h1", text: "Market prices"
  end

  test "should create market price" do
    visit market_prices_url
    click_on "New market price"

    fill_in "Average price", with: @market_price.price
    fill_in "Category", with: @market_price.category
    fill_in "Date", with: @market_price.date
    fill_in "Location", with: @market_price.location
    fill_in "Product name", with: @market_price.product_name
    fill_in "City", with: @market_price.city
    fill_in "Unit", with: @market_price.unit
    click_on "Create Market price"

    assert_text "Market price was successfully created"
    click_on "Back"
  end

  test "should update Market price" do
    visit market_price_url(@market_price)
    click_on "Edit this market price", match: :first

    fill_in "Average price", with: @market_price.price
    fill_in "Category", with: @market_price.category
    fill_in "Date", with: @market_price.date
    fill_in "Location", with: @market_price.location
    fill_in "Max price", with: @market_price.max_price
    fill_in "Min price", with: @market_price.min_price
    fill_in "Product name", with: @market_price.product_name
    fill_in "City", with: @market_price.city
    fill_in "Unit", with: @market_price.unit
    click_on "Update Market price"

    assert_text "Market price was successfully updated"
    click_on "Back"
  end

  test "should destroy Market price" do
    visit market_price_url(@market_price)
    click_on "Destroy this market price", match: :first

    assert_text "Market price was successfully destroyed"
  end
end
