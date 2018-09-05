require 'pry'


require './lib/boat'
require './lib/renter'


class Dock

  attr_reader :name, :max_rental_time, :renters

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
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
        case1 = boat[:status] == true
        case2 = boat[:log] != max_rental_time
        if case1 && case2
          boat[:log] += 1
          # technically hours rented can be more than hours charged
          boat[:boat].add_hour
        end
      }
    }
  end

  def return(this_boat)
    renters.each { |renter|
      boats = renter.renting
      boats.each { |boat|
        boat[:boat] == this_boat ? boat[:status] = false : return
      }
    }
  end

  def revenue
    arr = all_boats
    sum = 0
    all_boats.each { |boat|
      hours = boat.hours_rented
      price = boat.price_per_hour
      sum += (hours * price)
    }
    return sum
  end

  def all_boats
    rentals = @renters.map {|renter|
      boats = renter.renting
      boats.map { |boat|
        boat[:boat]
      }
    }.flatten!.uniq
  end


end
