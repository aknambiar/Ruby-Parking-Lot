# frozen_string_literal: true

class Interface
  def initialize
    options = { "Park a car" =>

    }
  end

  def start
    puts "Parking Lot"
    puts "1. Park/Unpark"
    puts "3. Display all cars"
    puts "4. Display invoices"
    puts "5. Invoice lookup"
  end

  def parking; end

  def display_all_cars; end

  def display_invoice; end

  def lookup_invoice; end
  
  def validate_regn(regn) regn.match?(/[A-Za-z]{2}[0-9]{8}/) end
end

# In = Interface.new
# puts In.validateRegn("AB")
# puts In.validateRegn("AB1245")
# puts In.validateRegn("AB12345678")