require_relative 'product'
require_relative 'products_view'

class ProductsController
  attr_reader :cart
  
  def initialize(repository)
    @repository = repository
    @cart = []
    @view = ProductsView.new
  end
end
