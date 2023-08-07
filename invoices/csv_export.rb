# frozen_string_literal: true

class CsvExport
  def write_invoice(invoice)
    IO.write("./invoices/#{invoice[:id]}.csv", 'Format: CSV')
    IO.write("./invoices/#{invoice[:id]}.csv", invoice.values.join(', '))
  end
end
