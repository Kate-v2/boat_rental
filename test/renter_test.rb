require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

require './lib/renter'
# require './lib/boat'
# require './lib/dock'


class RenterTest < Minitest::Test

  def test_it_exists
    assert_instance_of Renter, Renter.new("Patrick Star", "4242424242424242")
  end

  def test_it_gets_defaults_and_attrubutes
    renter = Renter.new("Patrick Star", "4242424242424242")
    # -- default --
    # assert_nil renter.dock
    # -- assigned --
    assert_equal "Patrick Star", renter.name
    assert_equal "4242424242424242", renter.credit_card_number
  end




end
