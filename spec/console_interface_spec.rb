# frozen_string_literal: true

require_relative '../interface'

RSpec.describe Interface do
  let(:interface) { Interface.new }
  before { allow($stdout).to receive(:write) }

  it 'should take input from the user' do
    allow(interface).to receive(:gets).and_return('hello')

    result = interface.input 'Enter text'

    expect(result).to eq('hello')
  end

  context 'When receiving a registration number' do
    it 'should return true if number is valid' do
      registration_number = 'AB12345678'

      valid = interface.send(:validate, registration_number)

      expect(valid).to be_truthy
    end

    it 'should return false if number is invalid' do
      registration_number = 'AB123'

      valid = interface.send(:validate, registration_number)

      expect(valid).to be_falsy
    end
  end
end
