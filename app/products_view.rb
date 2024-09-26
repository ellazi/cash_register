class ProductsView
  def display_products(products)
    puts "| Id | Product Code | Name | Price |"
    puts "| -- | ------------ | ---- | ----- |"
    products.each do |product|
      puts "| #{product.id} | #{product.product_code} | #{product.name} | #{product.price} € |"
    end
  end

  def ask_for_product_id
    puts ""
    puts "Please enter the id of the product you would like to add:"
    gets.chomp.to_i
  end

  def ask_how_many
    puts "How many would you like to add?"
    gets.chomp.to_i
  end

  def display_success(n, product)
    puts "You have successfully added #{n} #{product.name} to your cart."
  end

  def display_cart(basket, total_price)
    puts "Your cart:"
    puts "| Basket | Total price expected |"
    puts "| ------ | -------------------- |"
    puts "| #{basket} |  #{total_price} € |"
  end
end
