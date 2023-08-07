# frozen_string_literal: true

class CsvExport
  def write_invoice(invoice)
    IO.write("./invoices/#{invoice[:id]}.csv", "Format: CSV\n")
    IO.write("./invoices/#{invoice[:id]}.csv", invoice.values.join(', '), mode: 'a')
  end
end
