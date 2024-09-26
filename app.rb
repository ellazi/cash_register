require_relative "router"
require_relative "app/product_repository"
require_relative "app/products_controller"

csv_file = File.join(__dir__, 'data/products.csv')
product_repository = ProductRepository.new(csv_file)
products_controller = ProductsController.new(product_repository)

router = Router.new(products_controller)

router.run
