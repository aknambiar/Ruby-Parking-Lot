# frozen_string_literal: true

class CsvExport
  def write_invoice(invoice)
    IO.write("./invoices/#{invoice[:id]}.csv", invoice.members.join(', ')+"\n")
    IO.write("./invoices/#{invoice[:id]}.csv", invoice.values.join(', '), mode: 'a')
  end
end
