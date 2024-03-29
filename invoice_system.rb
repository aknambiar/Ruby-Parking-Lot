# frozen_string_literal: true

# Handles and generates invoices for parking system
class InvoiceSystem
  require_relative 'constants'
  include Constants

  Invoice = Struct.new(:id, :registration_number, :entry_time, :exit_time, :duration, :amount)

  def initialize
    @invoice_list = []
    @incrementing_id = INITIAL_ID_NUMBER
  end

  def generate_invoice(registration_number, entry_time)
    invoice_id = calculate_id
    exit_time = Time.now
    duration = calculate_duration(entry_time, exit_time)
    amount = calculate_amount(duration)
    @invoice_list.append(Invoice.new(invoice_id, registration_number, entry_time.strftime('%H:%M:%S'),
                                     exit_time.strftime('%H:%M:%S'), duration, amount)).last
  end

  def calculate_id
    @incrementing_id += 1
  end

  def calculate_duration(entry_time, exit_time)
    (exit_time - entry_time).round
  end

  def calculate_amount(duration)
    PARKING_CHARGES.select { |slab| duration >= slab }.values.max
  end

  def display_invoices
    invoices = @invoice_list.map { |invoice| { id: invoice[:id], registration_number: invoice[:registration_number] } }
    return puts 'No invoices found' if invoices.empty?

    invoices.each do |invoice|
      puts "Id: #{invoice[:id]} | Car: #{invoice[:registration_number]}"
    end
  end

  def lookup_invoice(invoice_id)
    @invoice_list.detect { |invoice| invoice[:id] == invoice_id }
  end
end
