require 'minitest/autorun'
require 'minitest/rg'
require_relative '../tab.rb'
require_relative '../guest.rb'

class TabTest < MiniTest::Test
  def setup
    @guest_1 = Guest.new "Daniel", 10
    @tab_1 = Tab.new @guest_1, 2
  end

  def test_get_guest
    assert_equal @guest_1, @tab_1.guest
  end

  def test_get_amount
    assert_equal 2, @tab_1.balance
  end

  def test_get_paid
    assert_equal false, @tab_1.paid
  end

  def test_add__success
    @tab_1.add 8
    assert_equal 10, @tab_1.balance
  end

  def test_add__fail
    @tab_1.add 9
    assert_equal 2, @tab_1.balance
  end

  def test_pay_balance
    @tab_1.pay_balance
    assert_equal true, @tab_1.paid
    assert_equal 0, @tab_1.balance
    assert_equal 8, @guest_1.money
  end

  def test_can_add__true
    assert_equal true, @tab_1.can_add?(8)
  end

  def test_can_add__false
    assert_equal false, @tab_1.can_add?(9)
  end

end
