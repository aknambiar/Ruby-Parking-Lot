# frozen-string-literal: true

# Console interface for parking system
class Interface
  require_relative 'invoice_system'
  require_relative 'parking_lot'
  require_relative 'file_manager'
  require_relative 'helper_methods'

  include HelperMethods

  def initialize
    @options = { 1 => ['Park/Unpark a car',     method(:parking)],
                 2 => ['Display all cars',      method(:display_all_cars)],
                 3 => ['Display all invoices',  method(:display_invoices)],
                 4 => ['Invoice lookup',        method(:lookup_invoice)],
                 5 => ['Save invoice to disk',  method(:save_invoice)],
                 6 => ['Exit', nil] }

    @invoice_system = InvoiceSystem.new
    @parking_lot = ParkingLot.new
    @file_manager = FileManager.new
  end

  def start
    loop do
      @options.each { |key, value| puts "#{key}: #{value[0]}" }
      choice = input('Enter your choice').to_i
      break unless choice.between?(1, @options.keys.count - 1)

      @options[choice][1].call
    end
  end

  def parking
    registration_number = input 'Enter registration number'
    return puts 'Invalid registration number' unless validate(registration_number)

    case input 'Park/Unpark? [p/u]'
    when 'p', 'P' then puts park(registration_number)
    when 'u', 'U' then puts unpark(registration_number)
    else puts 'Error'
    end
  end

  def display_all_cars
    @parking_lot.display_all_cars
  end

  def display_invoices
    @invoice_system.display_invoices
  end

  def retrieve_invoice
    id = (input 'Enter invoice number').to_i
    @invoice_system.lookup_invoice(id)
  end

  def lookup_invoice
    invoice = retrieve_invoice
    return puts 'Invoice not found' unless invoice

    invoice.each_pair { |field, value| puts "#{field.capitalize} : #{value}" }
  end

  def save_invoice
    invoice = retrieve_invoice
    return puts 'Invoice not found' unless invoice

    @file_manager.save_invoice(invoice)
  end

  def validate(registration_number)
    registration_number.match?(/(^[A-Za-z]{2}[0-9]{8})$/)
  end

  private

  def park(registration_number)
    car = @parking_lot.park_car(registration_number)
    car ? "Parked at #{car[:slot]}" : 'No space left'
  end

  def unpark(registration_number)
    car = @parking_lot.unpark_car(registration_number)
    return 'Car does not exist' unless car

    @invoice_system.generate_invoice(car[:registration_number], car[:entry_time])
    "Unparked car from #{car[:slot]}"
  end
end
