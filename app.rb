require_relative 'app/product'
require_relative 'app/product_repository'

repository = ProductRepository.new

product1 = Product.new(product_code: 'GR1', name: 'Green Tea', price: 3.11)
product2 = Product.new(product_code: 'SR1', name: 'Strawberries', price: 5.00)
product3 = Product.new(product_code: 'CF1', name: 'Coffee', price: 11.23)

repository.add(product1)
repository.add(product2)
repository.add(product3)
