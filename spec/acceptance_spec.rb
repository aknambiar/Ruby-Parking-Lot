# frozen_string_literal: true

require_relative '../interface'

RSpec.describe Interface do
  let(:interface) { Interface.new }
  let(:registration_number) { 'AB12345678' }
  let(:invalid_registration_number) { 'AB123' }

  context 'When parking a car with a valid registration number' do
    it 'should park the car and return the parking slot' do
      allow(interface).to receive(:input).and_return(registration_number, 'p')

      expect { interface.parking }.to output(/Parked at 1/).to_stdout
    end
  end

  context 'When parking a car with an invalid registration number' do
    it 'should display an error message' do
      allow(interface).to receive(:input).and_return(invalid_registration_number, 'p')

      expect { interface.parking }.to output(/Invalid registration number/).to_stdout
    end
  end

  context 'When unparking a car' do
    before(:each) { allow(interface).to receive(:input).and_return(registration_number, 'u') }

    it 'should unpark the car and generate an invoice' do
      allow(interface).to receive(:input).and_return(registration_number, 'u')

      interface.send(:park, registration_number)

      expect { interface.parking }.to output(/Unparked car from 1/).to_stdout
    end

    it 'should display an error message if car does not exist' do
      allow(interface).to receive(:input).and_return(registration_number, 'u')

      expect { interface.parking }.to output(/Car does not exist/).to_stdout
    end
  end
end

RSpec.describe Interface do
  let(:interface) { Interface.new }
  let(:list_of_regn) { ['AB12345678', 'CD12345678', 'EF12345678'] }

  it 'should display the list of parked cars' do
    list_of_regn.each { |x| interface.send(:park, x) }

    list_of_regn.each_with_index do |x, slot|
      expect { interface.display_all_cars }.to output(/Regn No: #{x} | Slot: #{slot + 1}/).to_stdout
    end
  end
end

RSpec.describe Interface do
  let(:interface) { Interface.new }
  let(:list_of_regn) { ['AB12345678', 'CD12345678', 'EF12345678'] }

  it 'should display the list of all invoices' do
    list_of_regn.each do |registration_number|
      interface.send(:park, registration_number)
      interface.send(:unpark, registration_number)

      expect { interface.display_invoices }.to output(/Id: \d+ | Car: #{registration_number}/).to_stdout
    end
  end

  context 'When searching for a real invoice' do
    it 'should display a particular invoice' do
      allow(interface).to receive(:input).and_return('101')

      interface.send(:park, list_of_regn[0])
      interface.send(:unpark, list_of_regn[0])

      expect { interface.lookup_invoice }.to output(/Id : 101\nRegistration_number : #{list_of_regn[0]}/).to_stdout
    end
  end

  context 'When searching for a non-existent invoice' do
    it 'should display an error message' do
      allow(interface).to receive(:input).and_return('777')

      expect { interface.lookup_invoice }.to output(/Invoice not found/).to_stdout
    end
  end
end
