# frozen_string_literal: true

require_relative '../invoice_system'

RSpec.describe InvoiceSystem do
  let(:invoice_system) { InvoiceSystem.new }

  it 'generates an invoice' do
    regn = 'AB12345678'
    entry_time = Time.now

    invoice = invoice_system.generate_invoice(regn, entry_time)

    expect(invoice).to be_an_instance_of InvoiceSystem::Invoice
  end

  it 'calculates a new id for an invoice' do
    new_id = invoice_system.calculate_id

    expect(new_id).to eq(101)
  end

  it 'calculates the duration' do
    entry_time = Time.now
    exit_time = entry_time + 30.1

    duration = invoice_system.calculate_duration(entry_time, exit_time)

    expect(duration).to eq(30)
  end

  it 'calculates the amount based on the duration' do
    duration = 45

    amount = invoice_system.calculate_amount(duration)

    expect(amount).to be(300)
  end
end
