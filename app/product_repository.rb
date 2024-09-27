require 'csv'
require_relative 'product'

class ProductRepository
  attr_reader :products
  
  def initialize(csv_file)
    @csv_file = csv_file
    @products = []
    @next_id = 1
    load_csv
  end

  def create(product)
    product.id = @next_id
    @products << product
    @next_id += 1
    save_csv
  end

  def all
    @products
  end

  def find(id)
    @products.find { |product| product.id == id }
  end

  def add_discount(discount)
    @discount = discount
  end

  def remove_discount!
    @discount = nil
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_f
      @products << Product.new({ id: row[:id], product_code: row[:product_code], name: row[:name], price: row[:price], discount: row[:discount] })
    end
    @next_id = @products.empty? ? 1 : @products.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file, "wb", :write_headers => true, :headers => ["id", "product_code", "name", "price", "discount"]) do |csv|
      @products.each { |p| csv << [p.id, p.product_code, p.name, p.price, p.discount] }
    end
  end
end
