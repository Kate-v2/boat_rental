require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

require './lib/renter'
require './lib/boat'
require './lib/dock'


class DockTest < Minitest::Test

  def test_it_exists
    assert_instance_of Dock, Dock.new("The Rowing Dock", 3)
  end

  def test_it_gets_defaults_and_attrubutes
    dock = Dock.new("The Rowing Dock", 3)
    # -- defaults --
    assert_equal [], dock.renters
    # assert_equal 0, dock.revenue
    # -- assigned --
    assert_equal "The Rowing Dock", dock.name
    assert_equal 3, dock.max_rental_time
  end

  def test_it_rents_boats_to_renters
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal [], dock.renters

    patrick = Renter.new("Patrick Star", "4242424242424242")

    kayak_1 = Boat.new(:kayak, 20)
    dock.rent(kayak_1, patrick)
    boat1 = {boat: kayak_1, log: 0, status: true}
    assert_equal [patrick], dock.renters
    assert_equal [boat1], patrick.renting
    # Test calling on patrick directly
    # is same as calling on dock's pointer to patrick
    assert_equal [boat1], dock.renters[0].renting

    kayak_2 = Boat.new(:kayak, 20)
    dock.rent(kayak_2, patrick)
    boat2 = {boat: kayak_2, log: 0, status: true}
    assert_equal [patrick], dock.renters
    assert_equal [boat1, boat2], patrick.renting
  end

  def test_it_logs_hours
    dock = Dock.new("The Rowing Dock", 3)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    kayak_1 = Boat.new(:kayak, 20)
    dock.rent(kayak_1, patrick)
    assert_equal kayak_1, patrick.renting[0][:boat]
    assert_equal true, patrick.renting[0][:log] == 0

    dock.log_hour
    assert_equal true, patrick.renting[0][:log] == 1

    kayak_2 = Boat.new(:kayak, 20)
    dock.rent(kayak_2, patrick)
    assert_equal kayak_2, patrick.renting[1][:boat]
    assert_equal true, patrick.renting[1][:log] == 0

    dock.log_hour
    assert_equal true, patrick.renting[0][:log] == 2
    assert_equal true, patrick.renting[1][:log] == 1

    assert_equal 2, kayak_1.hours_rented
    assert_equal 1, kayak_2.hours_rented
  end

  def test_it_can_return_a_boat
    dock = Dock.new("The Rowing Dock", 3)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    assert_equal kayak_1, patrick.renting[0][:boat]
    assert_equal true, patrick.renting[0][:status]

    dock.return(kayak_1)
    assert_equal kayak_1, patrick.renting[0][:boat]
    assert_equal false, patrick.renting[0][:status]

    assert_equal kayak_2, patrick.renting[1][:boat]
    assert_equal true, patrick.renting[1][:status]

    dock.log_hour
    assert_equal true, patrick.renting[0][:log] == 0
    assert_equal true, patrick.renting[1][:log] == 1
  end

  def test_it_gets_revenue
    dock = Dock.new("The Rowing Dock", 3)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.log_hour
    dock.log_hour
    rev = 20 * 2 * 3
    assert_equal rev, dock.revenue
    # -- at max time, so logger will not be incremented
    dock.log_hour
    assert_equal rev, dock.revenue
  end

  def test_it_can_handle_two_renters
    dock = Dock.new("The Rowing Dock", 3)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    not_patrick = Renter.new("Not Patrick Star", "4242424242424242")

    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.log_hour
    rev1 = 20 * 2 * 2
    dock.return(kayak_1)
    dock.log_hour
    rev2 = 20 * 1 * 1
    dock.rent(kayak_1, not_patrick)
    dock.log_hour
    dock.log_hour
    rev3 = 20 * 1 * 2 # and 0 for patrick's overdue boat

    total = rev1 + rev2 + rev3

    assert_equal total, dock.revenue
  end






end


# --- Iteration 3 ---

# dock = Dock.new("The Rowing Dock", 3)
# kayak_1 = Boat.new(:kayak, 20)
# kayak_2 = Boat.new(:kayak, 20)
# canoe = Boat.new(:canoe, 25)
# sup_1 = Boat.new(:standup_paddle_board, 15)
# sup_2 = Boat.new(:standup_paddle_board, 15)
# patrick = Renter.new("Patrick Star", "4242424242424242")
# eugene = Renter.new("Eugene Crabs", "1313131313131313")
#



# # ONE renter
# dock.rent(kayak_1, patrick)
# dock.rent(kayak_2, patrick)
# dock.log_hour
# dock.rent(canoe, patrick)
# dock.log_hour
# dock.return(kayak_1)
# dock.return(kayak_2)
# dock.return(canoe)
# dock.revenue
#
# # SECOND renter
# dock.rent(sup_1, eugene)
# dock.rent(sup_2, eugene)
# dock.log_hour
# dock.log_hour
# dock.log_hour
#
# # Any hours rented past the max rental time are not counted
# dock.log_hour
# dock.log_hour
# dock.return(sup_1)
# dock.return(sup_2)
# dock.revenue
# # 195
