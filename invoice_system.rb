# frozen_string_literal: true

# Handles and generates invoices for parking system
class InvoiceSystem
  require_relative 'constants'
  include Constants

  Invoice = Struct.new(:id, :regn, :entry_time, :exit_time, :duration, :amount)

  def initialize
    @invoice_list = []
    @incrementing_id = INITIAL_ID_NUMBER
  end

  def generate_invoice(regn, entry_time)
    invoice_id = calculate_id
    exit_time = Time.now
    duration = calculate_duration(entry_time, exit_time)
    amount = calculate_amount(duration)
    @invoice_list.append(Invoice.new(invoice_id, regn, entry_time.strftime('%H:%M:%S'),
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

  def list_all_invoices
    @invoice_list.map { |invoice| { id: invoice[:id], regn: invoice[:regn] } }
  end

  def lookup_invoice(invoice_id)
    @invoice_list.detect { |invoice| invoice[:id] == invoice_id }
  end
end
