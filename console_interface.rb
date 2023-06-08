class Interface
  # RegNum = Struct.new(:regn) do
  #   def valid?(regn)
  #     regn.match?(/[A-Za-z]{2}[0-9]{8}/)
  #   end
  # end

  def initialize
    require_relative 'invoice_system'
    require_relative 'parking_lot'

    @options = { 1 => ['Park/Unpark a car',     method(:parking)],
                 2 => ['Display all cars',      method(:display_all_cars)],
                 3 => ['Display all invoices',  method(:display_invoices)],
                 4 => ['Invoice lookup',        method(:lookup_invoice)],
                 5 => ['Exit',                  method(:stop)] }
    @invoice_system = InvoiceSystem.new
    @parking_lot = ParkingLot.new
  end

  def input(text)
    puts text
    gets.chomp
  end

  def stop
    exit
  end

  def start
    loop do
      @options.each { |key, value| puts "#{key}: #{value[0]}" }
      choice = input('Enter your choice').to_i
      @options[choice][1].call if choice.between?(1, @options.keys.count)
    end
  end

  def parking
    regn = input 'Enter registration number'
    return puts 'Invalid' unless validate(regn)

    case input 'Park/Unpark? [p/u]'
    when 'p', 'P'
      puts park(regn)
    when 'u', 'U'
      puts unpark(regn)
    else
      puts 'Error'
    end
  end

  def park(regn)
    "Parked at #{@parking_lot.park_car(regn)}"
  end

  def unpark(regn)
    car = @parking_lot.unpark_car(regn)
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

  def lookup_invoice
    id = input 'Enter invoice number'
    invoice = @invoice_system.lookup_invoice(id)
    invoice.each { |field| puts "#{field} : #{invoice[field]}" }
  end

  def validate(regn)
    regn.match?(/[A-Za-z]{2}[0-9]{8}/)
  end
end

In = Interface.new
In.start
# puts In.validate("AB")
# puts In.validate("AB1245")
# puts In.validate("AB12345678")