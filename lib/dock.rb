require 'pry'


require './lib/boat'
require './lib/renter'


class Dock
  # ONLY rents to one person at a time???
  # how else would log_hour work

  attr_reader :name, :max_rental_time, :revenue, :renters

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @revenue = 0
    @renters = []
  end

  def rent(boat, renter)
    @renters << renter
    renter.renting << {boat: boat, log: 0, status: true}
    @renters.uniq!
  end

  def log_hour
    # technically we don't need to generate
    # a receipt for each renter, but boats[:log] partially does that
    renters.each { |renter|
      boats = renter.renting
      boats.each { |boat|
        # binding.pry
        if boat[:log] != max_rental_time
          boat[:log] += 1
          # technically hours rented can be more than hours charged
          boat[:boat].add_hour
        end
      }
    }
  end

  def return(boat)

  end

  def add_to_revenue

  end

end
