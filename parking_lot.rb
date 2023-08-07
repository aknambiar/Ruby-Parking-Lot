# frozen-string-literal: true

# Parking and unparks cars
class ParkingLot
  require_relative 'constants'
  include Constants

  Car = Struct.new(:registration_number, :entry_time, :slot)

  def initialize
    @car_list = []
  end

  def park_car(registration_number)
    slot = find_empty_slot
    @car_list.push(Car.new(registration_number, Time.now, slot)).last if slot
  end

  def unpark_car(registration_number)
    @car_list.delete(find_car(registration_number))
  end

  def find_car(registration_number)
    @car_list.detect { |car| car[:registration_number] == registration_number }
  end

  def find_empty_slot
    occupied = @car_list.map { |car| car[:slot] }
    (1..MAX_CARS).find { |slot| !occupied.include?(slot) }
  end

  def display_all_cars
    return puts 'No cars found' unless @car_list

    @car_list.each do |car|
      puts "Regn No: #{car[:registration_number]} | Slot: #{car[:slot]}"
    end
  end
end
