# frozen-string-literal: true

# Manages the parking and unparking of cars
class ParkingLot
  require_relative 'car'
  @@max_cars = 10

  def initialize
    @car_list = {}
    @slots = Array.new(@@max_cars, false)
  end

  def park(regn)
    slot = find_empty_slot
    if slot
      @slots[slot] = true
      # @car_list[regn] = { 'car' => Car.new(regn), 'slot' => slot }
      @car_list[regn] = Car.new(regn, Time.now.strftime('%H:%M:%S'), slot)
    end
    slot
  end

  def unpark(regn)
    slot = find_occupied_slot(regn)
    if slot
      @slots[slot] = false
      @car_list.delete(regn)
    end
    slot
  end

  def find_car(regn)
    @car_list[regn]['car']
  end

  def find_empty_slot
    @slots.each_with_index do |occupied, slot|
      return slot unless occupied
    end
    false
  end

  def find_occupied_slot(regn)
    @car_list[regn]['slot']
  end
end

pl = ParkingLot.new
pl.park(11)
pl.park(22)
pl.park(33)
pl.unpark(33)
pl.park(44)
puts pl.car_list
