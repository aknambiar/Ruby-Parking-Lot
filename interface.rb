# frozen-string-literal: true

# Console interface for parking system
class Interface
  def initialize
    require_relative 'invoice_system'
    require_relative 'parking_lot'

    @options = { 1 => ['Park/Unpark a car',     method(:parking)],
                 2 => ['Display all cars',      method(:display_all_cars)],
                 3 => ['Display all invoices',  method(:display_invoices)],
                 4 => ['Invoice lookup',        method(:lookup_invoice)],
                 5 => ['Write invoice to file', method(:write_to_file)],
                 6 => ['Exit', nil] }

    @invoice_system = InvoiceSystem.new
    @parking_lot = ParkingLot.new
  end

  def input(text)
    puts text
    gets.chomp
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
    regn = input 'Enter registration number'
    return puts 'Invalid registration number' unless validate(regn)

    case input 'Park/Unpark? [p/u]'
    when 'p', 'P' then puts park(regn)
    when 'u', 'U' then puts unpark(regn)
    else puts 'Error'
    end
  end

  def park(regn)
    car = @parking_lot.park_car(regn)
    car ? "Parked at #{car[:slot]}" : 'No space left'
  end

  def unpark(regn)
    car = @parking_lot.unpark_car(regn)
    return 'Car does not exist' unless car

    @invoice_system.generate_invoice(car[:regn], car[:entry_time])
    "Unparked car from #{car[:slot]}"
  end

  def display_all_cars
    @parking_lot.car_list.each do |car|
      puts "Regn No: #{car[:regn]} | Slot: #{car[:slot]}"
    end
  end

  def display_invoices
    @invoice_system.list_all_invoices.each do |invoice|
      puts "Id: #{invoice[:id]} | Car: #{invoice[:regn]}"
    end
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

  def write_to_file
    invoice = retrieve_invoice
    return puts 'Invoice not found' unless invoice
    
    IO.write("./#{invoice[:id]}.csv", invoice.values.join(', '))
  end

  def validate(regn)
    regn.match?(/[A-Za-z]{2}[0-9]{8}/)
  end
end
