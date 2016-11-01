require 'test_helper'

class TradingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trading = tradings(:one)
  end

  test "should get index" do
    get tradings_url
    assert_response :success
  end

  test "should get new" do
    get new_trading_url
    assert_response :success
  end

  test "should create trading" do
    assert_difference('Trading.count') do
      post tradings_url, params: { trading: { amount: @trading.amount, url: @trading.url } }
    end

    assert_redirected_to trading_url(Trading.last)
  end

  test "should show trading" do
    get trading_url(@trading)
    assert_response :success
  end

  test "should get edit" do
    get edit_trading_url(@trading)
    assert_response :success
  end

  test "should update trading" do
    patch trading_url(@trading), params: { trading: { amount: @trading.amount, url: @trading.url } }
    assert_redirected_to trading_url(@trading)
  end

  test "should destroy trading" do
    assert_difference('Trading.count', -1) do
      delete trading_url(@trading)
    end

    assert_redirected_to tradings_url
  end
end
