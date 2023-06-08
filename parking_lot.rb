# frozen-string-literal: true

# Parking and unparks cars
class ParkingLot
  Car = Struct.new(:regn, :entry_time, :slot)
  attr_reader :car_list

  def initialize
    @max_cars = 2
    @car_list = []
  end

  def park_car(regn)
    slot = find_empty_slot
    @car_list.push(Car.new(regn, Time.now, slot)).last if slot
  end

  def unpark_car(regn)
    @car_list.delete(find_car(regn))
  end

  def find_car(regn)
    @car_list.detect { |car| car[:regn] == regn }
  end

  def find_empty_slot
    occupied = @car_list.map { |car| car[:slot] }
    (1..@max_cars).find { |slot| !occupied.include?(slot) }
  end
end
