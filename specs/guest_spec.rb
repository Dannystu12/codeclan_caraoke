require 'minitest/autorun'
require 'minitest/rg'
require_relative '../guest.rb'

class GuestTest < MiniTest::Test
  def setup
    @guest_1 = Guest.new "Daniel", 10
  end

  def test_get_name
    assert_equal "Daniel", @guest_1.name
  end

  def test_get_money
    assert_equal 10, @guest_1.money
  end

  def test_pay_money__success
    result = @guest_1.pay_money 5.40
    assert_equal 4.60, @guest_1.money
    assert_equal true, result
  end

  def test_pay_money__fail
    result = @guest_1.pay_money 100
    assert_equal 10, @guest_1.money
    assert_equal false, result

    result = @guest_1.pay_money -1
    assert_equal 10, @guest_1.money
    assert_equal false, result
  end
end
