require_relative '../app/controllers/products_controller'
require_relative '../app/repositories/product_repository'
require_relative '../app/views/products_view'

RSpec.describe "ProductsController" do
  let(:csv_path) { "spec/support/products.csv" }
  let(:repository) { ProductRepository.new(csv_path) }
  let(:view) { ProductsView.new }
  let(:controller) { ProductsController.new(repository) }

  before do
    allow(STDOUT).to receive(:puts)  # Suppress output from puts
  end

  describe "#initialize" do
    it "should be initialized with a ProductRepository`" do
      expect(controller).to be_a(ProductsController)
    end

    it "inizializes a cart array" do
      expect(controller.cart).to be_a(Array)
    end

    it "inizializes a view instance" do
      expect(view).to be_a(ProductsView)
    end
  end

  describe "#add" do
    it "should ask the user for a product id, then add to cart" do
      allow_any_instance_of(Object).to receive(:gets).and_return("2", "1")
      controller.add

      expect(controller.cart.length).to eq(1)
    end

    it "should display an error message if the product does not exist" do
      allow(repository).to receive(:find).with(4).and_return(nil)

      expect(STDOUT).to receive(:puts).with("Type a valid id.")

      result = repository.find(4)
      puts "Type a valid id." if result.nil?
    end
  end

  describe "#add_frontend" do
    it "should add a product to the cart" do
      controller.add_frontend(repository.find(1))
      controller.cart.include?(repository.find(1))
    end
  end

  describe "#checkout" do
    it "should have a basket with products code and total price" do
      allow_any_instance_of(Object).to receive(:gets).and_return("2", "2")
      controller.add

      expect(controller.cart.length).to eq(2)
      expect(controller.cart.map(&:product_code)).to eq(["SR1", "SR1"])
      expect(controller.total).to eq(10.00)
    end
  end

  describe "#checkout_frontend" do
    it "should return a basket with prducts codes" do
      allow_any_instance_of(Object).to receive(:gets).and_return("1", "1")
      controller.add
      allow_any_instance_of(Object).to receive(:gets).and_return("2", "1")
      controller.add

      expect(controller.cart.map(&:product_code)).to eq(["GR1", "SR1"])
    end

    it "should return the total price" do
      allow_any_instance_of(Object).to receive(:gets).and_return("1", "1")
      controller.add
      allow_any_instance_of(Object).to receive(:gets).and_return("2", "1")
      controller.add

      expect(controller.total).to eq(8.11)
    end
  end

  describe "#buy_one_get_one_free" do
    it "should calculate the total price for the 'buy_one_get_one_free' discount" do
      allow_any_instance_of(Object).to receive(:gets).and_return("1", "2")
      controller.add

      expect(controller.buy_one_get_one_free("GR1", 3.11)).to eq(3.11)
    end
  end

  describe "#fifty_cents_off" do
    it "should calculate the total price for the 'fifty_cents_off' discount" do
      allow_any_instance_of(Object).to receive(:gets).and_return("2", "3")
      controller.add

      expect(controller.fifty_cents_off("SR1", 5.00)).to eq(13.50)
    end
  end

  describe "#one_third_off" do
    it "should calculate the total price for the 'one_third_off' discount" do
      allow_any_instance_of(Object).to receive(:gets).and_return("3", "3")
      controller.add

      expect(controller.one_third_off("CF1", 11.23)).to eq(22.46)
    end
  end

  describe "#total" do
    it "should calculate the total price" do
      allow_any_instance_of(Object).to receive(:gets).and_return("1", "2")
      controller.add

      allow_any_instance_of(Object).to receive(:gets).and_return("2", "3")
      controller.add

      allow_any_instance_of(Object).to receive(:gets).and_return("3", "3")
      controller.add

      expect(controller.total).to eq(39.07)
    end
  end
end
