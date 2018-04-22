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

  def test_can_afford__true
    assert_equal true, @guest_1.can_afford?(10)
  end

  def test_can_afford__false
    assert_equal false, @guest_1.can_afford?(11)
    assert_equal false, @guest_1.can_afford?(-1)
  end

  def test_pay_money__success
    @guest_1.pay_money 5.40
    assert_equal 4.60, @guest_1.money
  end

  def test_pay_money__fail
    @guest_1.pay_money 100
    assert_equal 10, @guest_1.money

    @guest_1.pay_money -1
    assert_equal 10, @guest_1.money
  end
end
