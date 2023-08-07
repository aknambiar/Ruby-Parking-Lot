# frozen_string_literal: true

class TxtExport
  def write_invoice(invoice)
    IO.write("./invoices/#{invoice[:id]}.txt", "Format: TXT\n")
    IO.write("./invoices/#{invoice[:id]}.txt", invoice.values.join(' '), mode: 'a')
  end
end
