require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

require './lib/boat'


class BoatTest < Minitest::Test

  def test_it_exits
    assert_instance_of Boat, Boat.new(:kayak, 20)
  end

  def test_it_sets_defaults_and_gets_attributes
    boat = Boat.new(:kayak, 20)

    # -- default --
    assert_equal 0, boat.hours_rented
    # -- assigned --
    assert_equal :kayak, boat.type
    assert_equal 20, boat.price_per_hour
  end

  def test_it_can_add_hours
    boat = Boat.new(:kayak, 20)
    # -- no hours added --
    assert_equal 0, boat.hours_rented
    # -- hours added --
    boat.add_hour
    assert_equal 1, boat.hours_rented

    boat.add_hour
    assert_equal 2, boat.hours_rented
  end


end
