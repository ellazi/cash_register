require_relative 'product'
require_relative 'products_view'

class ProductsController
  attr_reader :cart

  def initialize(repository)
    @repository = repository
    @cart = []
    @view = ProductsView.new
  end

  def add
    list
    id = @view.ask_for_product_id
    product = @repository.find(id)
    n = @view.ask_how_many
    n.times { @cart << product }
    @view.display_success(n, product)
  end

  def add_frontend(product)
    @cart << product
  end

  def list
    products = @repository.all
    @view.display_products(products)
  end

  def checkout
    @codes_list = @cart.map { |product| product.product_code }
    basket = @codes_list.shuffle.join(', ')
    total_price = total.round(2)
    @view.display_cart(basket, total_price)
  end

  def checkout_frontend(cart)
    @cart = cart
    codes_list = @cart.map { |product| product.product_code }
    basket = codes_list.shuffle.join(', ')
    total_price = total.round(2)
    [basket, total_price]
  end

  def total
    sum1 = 0
    sum2 = 0
    sum3 = 0
    sum4 = 0
    @cart.each do |product|
      if product.discount == "Buy one get one free"
        sum1 = buy_one_get_one_free(product.product_code, product.price)
      elsif product.discount == "Fifty cents off"
        sum2 = fifty_cents_off(product.product_code, product.price)
      elsif product.discount == "One third off"
        sum3 = one_third_off(product.product_code, product.price)
      else
        sum4 = no_discount(product.price)
      end
    end
    sum1 + sum2 + sum3 + sum4
  end

  # Calculate discount
  def buy_one_get_one_free(product_code, price)
    list = @cart.select { |product| product.product_code == product_code }
    list.count >= 2 ? ((list.count / 2) * price) + ((list.count % 2) * price) : (list.count * price)
  end

  def fifty_cents_off(product_code, price)
    list = @cart.select { |product| product.product_code == product_code }
    list.count >= 3 ? (list.count * (price - 0.50)) : (list.count * price)
  end

  def one_third_off(product_code, price)
    list = @cart.select { |product| product.product_code == product_code }
    list.count >= 3 ? (list.count * (price * 2/3)) : (list.count * price)
  end

  def no_discount(price)
    list = @cart.select { |product| product.discount.nil? || !Product::DISCOUNTS.include?(product.discount) }
    list.count * price
  end
end
