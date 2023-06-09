# frozen_string_literal: true

require_relative '../parking_lot'

RSpec.describe 'A parking lot' do
  before :each do
    @parking_lot = ParkingLot.new
    @regn = 'AB12345678'
    @new_car = ParkingLot::Car.new(@regn, Time.now, 3)
    @parking_lot.instance_variable_set('@car_list', [@new_car])
  end

  it 'parks a car' do
    car = @parking_lot.park_car(@regn)
    expect(car).to be_an_instance_of ParkingLot::Car
  end

  it 'fails to park a car when no slots are left' do
    @parking_lot.instance_variable_set('@max_cars', 0)
    car = @parking_lot.park_car(@regn)
    expect(car).to be_falsy
  end

  it 'unparks a car' do
    car = @parking_lot.unpark_car(@regn)
    expect(car).to be_an_instance_of ParkingLot::Car
  end

  it 'fails to unpark a car when it does not exist' do
    fake_regn = 'AB00000000'
    car = @parking_lot.unpark_car(fake_regn)
    expect(car).to be_falsy
  end

  it 'picks a car based on a registration number' do
    car = @parking_lot.find_car(@regn)
    expect(car).to be_an_instance_of ParkingLot::Car and expect(car[:regn]).to eq(@regn)
  end
end
