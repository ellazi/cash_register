class Product
  attr_reader :product_code, :name, :price
  attr_accessor :discount, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @product_code = attributes[:product_code]
    @name = attributes[:name]
    @price = attributes[:price]
    @discount = attributes[:discount] || nil
  end
end
