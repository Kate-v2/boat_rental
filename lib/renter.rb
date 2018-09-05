require 'pry'


require './lib/boat'



class Renter
  attr_reader :name, :credit_card_number, :renting

  def initialize(name, credit_card_number)
    @name = name
    @credit_card_number = credit_card_number
    @renting = []
  end
end
