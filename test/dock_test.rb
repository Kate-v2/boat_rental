require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

# require './lib/renter'
# require './lib/boat'
require './lib/dock'


class DockTest < Minitest::Test

  def test_it_exists
    assert_instance_of Dock, Dock.new("The Rowing Dock", 3)
  end

  def test_it_gets_attrubutes
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal "The Rowing Dock", dock.name
    assert_equal 3, dock.max_rental_time
  end

end
