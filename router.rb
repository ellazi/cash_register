class Router
  def initialize(products_controller)
    @products_controller = products_controller
    @running = true
  end

  def run
    puts "---------------------------"
    puts "   Welcome to our shop!!   "
    puts "---------------------------"

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @products_controller.list
    when 2 then @products_controller.add
    when 3 then @products_controller.checkout
    when 4 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What would you like to do?"
    puts ""
    puts "1 - List all products"
    puts "2 - Add a product to your cart"
    puts "3 - See your cart"
    puts "4 - Stop and exit the program"
  end
end
