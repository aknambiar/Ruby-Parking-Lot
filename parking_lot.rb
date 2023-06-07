# frozen-string-literal: true

# Manages the parking and unparking of cars
class ParkingLot
  Car = Struct.new(:regn, :entry_time, :slot)
  attr_reader :car_list

  def initialize
    @max_cars = 10
    @car_list = []
  end

  def park(regn)
    slot = find_empty_slot
    @car_list.push(Car.new(regn, Time.now.strftime('%H:%M:%S'), slot)) if slot
    slot
  end

  def unpark(regn)
    @car_list.delete(find_car(regn))
  end

  def find_car(regn)
    @car_list.detect { |car| car[:regn] == regn }
  end

  def find_empty_slot # refactor
    occupied = @car_list.map { |car| car[:slot] }
    (1..@max_cars).find { |slot| !occupied.include?(slot) }
  end
end

pl = ParkingLot.new
pl.park(11)
pl.park(22)
pl.park(33)
# pl.unpark(33)
# pl.park(44)
pl.unpark(33)
puts pl.car_list
