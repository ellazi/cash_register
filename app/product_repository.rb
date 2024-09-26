require 'csv'
require_relative 'product'

class ProductRepository
  attr_reader :products

  def initialize(csv_path)
    @csv_path = csv_path || '../data/products.csv'
    @products = []
    # @next_id = 1
    # load_csv
  end

  def all
    @products
  end

  def find(id)
    @products.find { |product| product.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_f
      @products << Product.new({ id: row[:id], product_code: row[:product_code], name: row[:name], price: row[:price], discount: row[:discount] })
    end
  end

  # def load_csv
  #   CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
  #     row[:id] = row[:id].to_i
  #     row[:price] = row[:price].to_f
  #     @products << Product.new({ id: row[:id], product_code: row[:product_code], name: row[:name], price: row[:price], discount: row[:discount] })
  #   end
  #   @next_id = @products.empty? ? 1 : @products.last.id + 1
  # end
end

csv_path = File.expand_path('../data/products.csv', __dir__)
p ProductRepository.new(csv_path)
