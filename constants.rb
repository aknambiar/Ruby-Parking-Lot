# frozen_string_literal: true

module Constants
  INVOICE_SAVE_PATH = './invoices'
  FILETYPE_SUFFIX = '_export.rb'
  PARKING_CHARGES = { 0 => 100, 10 => 200, 30 => 300, 60 => 500 } # {duration:cost}
  INITIAL_ID_NUMBER = 100
  MAX_CARS = 10
end
