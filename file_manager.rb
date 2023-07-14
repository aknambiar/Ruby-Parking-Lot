# frozen_string_literal: true

# Handles writing data to disk
class FileManager
  require_relative 'helper_methods'
  require_relative 'constants'

  include Constants
  include HelperMethods

  def initialize
    @filetypes = list_filetypes
  end

  def list_filetypes
    Dir["#{INVOICE_SAVE_PATH}/*"]
      .filter { |file| file[FILETYPE_SUFFIX] }
      .map { |file| file[/\w*#{FILETYPE_SUFFIX}/].split('_').first }
  end

  def save_invoice(invoice)
    puts "Filetypes supported: #{@filetypes.join(' ')}"

    file_choice = input 'Enter filetype:'
    @filetypes.include?(file_choice) ? write_to_file(file_choice, invoice) : puts('Filetype not supported')
  end

  def write_to_file(type, invoice)
    # require "#{INVOICE_SAVE_PATH}/#{type}#{FILETYPE_SUFFIX}"
    require INVOICE_SAVE_PATH + '/' + type + FILETYPE_SUFFIX

    begin
      write_invoice(invoice)
      puts 'Written to file successfully'
    rescue
      puts 'An error occurred'
    end
  end
end
