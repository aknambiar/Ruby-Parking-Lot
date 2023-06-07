# frozen_string_literal: true

# docu ment ation
class InvoiceSystem
  Invoice = Struct.new(:id, :regn, :entry_time, :exit_time, :duration, :amount)

  attr_reader :invoice_list

  def initialize
    @prices = { 0 => 100, 10 => 200, 30 => 300, 60 => 500 }
    @invoice_list = []
    @invoice_id_generator = 100
  end

  def generate_invoice(regn,entry_time)
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
    @prices.select { |slab| duration > slab }.values.max
  end

  def list_all_invoices
    @invoice_list.map { |invoice| invoice[:id] }
  end

  def lookup_invoice(invoice_id)
    @invoice_list.select { |invoice| invoice[:id] == invoice_id }
  end
end

c = InvoiceSystem.new
# c.generate('AB124', Time.now)
# c.generate('AB124', Time.now)
# c.generate('AB123', Time.now)
# puts c.get_all_invoices
puts c.calculate_amount(35)
