require_relative '../app/products_controller'
require_relative '../app/product_repository'
require_relative '../app/products_view'

RSpec.describe "ProductsController", :product do
  let(:products) do
    [
      [ "id", "product_code", "name", "price", "discount" ],
      [ 1, "GR1", "Green Tea", 3.11, "buy_1_get_1" ],
      [ 2, "SR1", "Strawberries", 5.0, "50c_off" ],
      [ 3, "CF1", "Coffee", 11.23, "one_third_off" ]
    ]
  end
  let(:csv_path) { "spec/support/products.csv" }
  let(:repository) { ProductRepository.new(csv_path) }

  describe "#initialize" do
    it "should be initialized with a ProductRepository`" do
      controller = ProductsController.new(repository)
      expect(controller).to be_a(ProductsController)
    end

    it "inizializes a cart array" do
      expect(ProductsController.new(repository).cart).to be_a(Array)
    end

    it "inizializes a view instance" do
      view = ProductsView.new
      expect(view).to be_a(ProductsView)
    end
  end
end
