require 'products_controller'
require 'product_repository'

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

  it "instantiates an empty cart" do
    expect(ProductsController.new(repository).cart).to eq([])
  end

  it "should be initialized with a ProductRepository instance" do
    controller = ProductsController.new(repository)
    expect(controller).to be_a(ProductsController)
  end

  describe "#add" do
    it "should ask the user for a product id, then add to cart" do
      controller = ProductsController.new(repository)

      allow_any_instance_of(Object).to receive(:gets).and_return("2", "1")
      controller.add

      expect(controller.cart.length).to eq(1)
    end
  end

  describe "#list" do
    it "should display all products in the repository" do
      controller = ProductsController.new(repository)

      expect(STDOUT).to receive(:puts).with("| Id | Product Code | Name | Price |")
      expect(STDOUT).to receive(:puts).with("| -- | ------------ | ---- | ----- |")
      products.drop(1).each do |product|
        expect(STDOUT).to receive(:puts).with("| #{product[0]} | #{product[1]} | #{product[2]} | #{product[3]} € |")
      end

      controller.list
    end
  end

  describe "#checkout" do
    it "should display the cart and the total price" do
      controller = ProductsController.new(repository)

      allow_any_instance_of(Object).to receive(:gets).and_return("2", "1")
      controller.add

      expect(STDOUT).to receive(:puts).with("Your cart:")
      expect(STDOUT).to receive(:puts).with("| Basket | Total price expected |")
      expect(STDOUT).to receive(:puts).with("| ------ | -------------------- |")
      expect(STDOUT).to receive(:puts).with("| #{controller.cart[0].product_code} |  #{controller.cart[0].price} € |")

      controller.checkout
    end
  end

  describe "#buy_one_get_one_free" do
    it "should calculate the total price for the 'buy_1_get_1' discount" do
      controller = ProductsController.new(repository)

      allow_any_instance_of(Object).to receive(:gets).and_return("1", "2")
      controller.add

      expect(controller.buy_1_get_1("GR1", 3.11)).to eq(3.11)
    end
  end

  describe "#fifty_cents_off" do
    it "should calculate the total price for the 'fifty_c_off' discount" do
      controller = ProductsController.new(repository)

      allow_any_instance_of(Object).to receive(:gets).and_return("2", "3")
      controller.add

      expect(controller.fifty_c_off("SR1", 5.00)).to eq(13.50)
    end
  end

  describe "#one_third_off" do
    it "should calculate the total price for the 'one_third_off' discount" do
      controller = ProductsController.new(repository)

      allow_any_instance_of(Object).to receive(:gets).and_return("3", "3")
      controller.add

      expect(controller.one_third_off("CF1", 11.23)).to eq(22.46)
    end
  end

  describe "#total" do
    it "should calculate the total price" do
      controller = ProductsController.new(repository)

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
