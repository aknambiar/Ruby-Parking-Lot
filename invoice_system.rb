# frozen_string_literal: true

# Handles and generates invoices for parking system
class InvoiceSystem
  Invoice = Struct.new(:id, :regn, :entry_time, :exit_time, :duration, :amount)

  def initialize
    @prices = { 0 => 100, 10 => 200, 30 => 300, 60 => 500 } # {duration:cost}
    @invoice_list = []
    @invoice_id_generator = 100
  end

  def generate_invoice(regn, entry_time)
    invoice_id = calculate_id
    exit_time = Time.now
    duration = calculate_duration(entry_time, exit_time)
    amount = calculate_amount(duration)
    @invoice_list.append(Invoice.new(invoice_id, regn, entry_time.strftime('%H:%M:%S'),
                                     exit_time.strftime('%H:%M:%S'), duration, amount))
  end

  def calculate_id
    @invoice_id_generator += 1
  end

  def calculate_duration(entry_time, exit_time)
    (exit_time - entry_time).round
  end

  def calculate_amount(duration)
    @prices.select { |slab| duration >= slab }.values.max
  end

  def list_all_invoices
    @invoice_list.map { |invoice| invoice[:id] }
  end

  def lookup_invoice(invoice_id)
    @invoice_list.detect { |invoice| invoice[:id] == invoice_id }
  end
end
