# frozen_string_literal: true

class TxtExport
  def write_invoice(invoice)
    IO.write("./invoices/#{invoice[:id]}.csv", 'Format: TXT')
    IO.write("./invoices/#{invoice[:id]}.txt", invoice.values.join(' '))
  end
end
