require "test_helper"

class MarketPricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_price = market_prices(:one)
  end

  test "should get index" do
    get market_prices_url
    assert_response :success
  end

  test "should get new" do
    get new_market_price_url
    assert_response :success
  end

  test "should create market_price" do
    assert_difference("MarketPrice.count") do
      post market_prices_url, params: { market_price: { price: @market_price.price, category: @market_price.category, date: @market_price.date, location: @market_price.location, product_name: @market_price.product_name, city: @market_price.city, unit: @market_price.unit } }
    end

    assert_redirected_to market_price_url(MarketPrice.last)
  end

  test "should show market_price" do
    get market_price_url(@market_price)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_price_url(@market_price)
    assert_response :success
  end

  test "should update market_price" do
    patch market_price_url(@market_price), params: { market_price: { price: @market_price.price, category: @market_price.category, date: @market_price.date, location: @market_price.location, product_name: @market_price.product_name, city: @market_price.city, unit: @market_price.unit } }
    assert_redirected_to market_price_url(@market_price)
  end

  test "should destroy market_price" do
    assert_difference("MarketPrice.count", -1) do
      delete market_price_url(@market_price)
    end

    assert_redirected_to market_prices_url
  end
end
