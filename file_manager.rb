# frozen_string_literal: true

# Handles writing data to disk
class FileManager
  require_relative 'helper_methods'

  include HelperMethods

  def initialize
    @path = './invoices/'
    @filetypes = list_filetypes
  end

  def list_filetypes
    Dir['./invoices/*']
      .filter { |file| file['_export.rb'] }
      .map { |file| file[/\w*_export.rb/].split('_').first }
  end

  def save_invoice(invoice)
    puts "Filetypes supported: #{@filetypes.join(' ')}"

    file_choice = input 'Enter filetype:'
    @filetypes.include?(file_choice) ? write_to_file(file_choice, invoice) : puts('Filetype not supported')
  end

  def write_to_file(type, invoice)
    require "./invoices/#{type}_export"

    begin
      write_invoice(invoice)
      puts 'Written to file successfully'
    rescue
      puts 'An error occurred'
    end
  end
end
