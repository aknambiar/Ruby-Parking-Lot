# frozen_string_literal: true

def write_invoice(invoice)
  IO.write("./invoices/#{invoice[:id]}.txt", invoice.values.join(', '))
end
