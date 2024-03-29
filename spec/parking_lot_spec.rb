# frozen_string_literal: true

require_relative '../parking_lot'
require_relative '../constants'

RSpec.describe ParkingLot do
  let(:parking_lot) { ParkingLot.new }
  let(:registration_number) { 'AB12345678' }

  context 'When parking a car' do
    it 'parks a car if slots are available' do
      car = parking_lot.park_car(registration_number)

      expect(car).to be_an_instance_of ParkingLot::Car
    end

    context 'The parking lot is full' do
      before { Constants::MAX_CARS = 0 }
      after { Constants::MAX_CARS = 10 }

      it 'fails to park a car' do
        car = parking_lot.park_car(registration_number)

        expect(car).to be_falsy
      end
    end
  end

  context 'When unparking a car' do
    it 'unparks a car if it exists' do
      parking_lot.park_car(registration_number)

      expect(parking_lot.unpark_car(registration_number)).to be_an_instance_of ParkingLot::Car
    end

    it 'fails to unpark a non-existent car' do
      missing_registration_number = 'AB00000000'

      expect(parking_lot.unpark_car(missing_registration_number)).to be_falsy
    end
  end
end

RSpec.describe ParkingLot do
  let(:parking_lot) { ParkingLot.new }
  let(:registration_number) { 'AB12345678' }

  it 'picks a car based on a registration number' do
    parking_lot.park_car(registration_number)

    car = parking_lot.find_car(registration_number)

    expect(car).to be_an_instance_of ParkingLot::Car and expect(car[:registration_number]).to eq(registration_number)
  end

  context 'When searching for a slot' do
    it 'finds the first slot available' do
      parking_lot.park_car(registration_number)

      expect(parking_lot.find_empty_slot).to eq(2)
    end

    context 'The parking lot is full' do
      before { Constants::MAX_CARS = 0 }
      after { Constants::MAX_CARS = 10 }
      
      it 'returns nil since no slots are available' do
        parking_lot.instance_variable_set('@max_cars', 0)

        expect(parking_lot.find_empty_slot).to be_falsy
      end
    end
  end
end
