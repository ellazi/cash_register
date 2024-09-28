require_relative '../app/repositories/product_repository'

RSpec.describe ProductRepository, :product do
  let(:products) do
    [
      [ "id", "product_code", "name", "price", "discount" ],
      [ 1, "GR1", "Green Tea", 3.11, "Buy one get one free" ],
      [ 2, "SR1", "Strawberries", 5.0, "Fifty cents off" ],
      [ 3, "CF1", "Coffee", 11.23, "One third off" ]
    ]
  end
  let(:csv_path) { "spec/support/products.csv" }
  let(:repository) { ProductRepository.new(csv_path) }

  describe "#initialize" do
    it "should be initialized with a csv file path" do
      ProductRepository.new(csv_path)
    end

    it "should load the products from the csv file" do
      CSV.read(csv_path, headers: true)
    end
  end

  describe "#all" do
    it "should return all the products stored by the repo" do
      repo = ProductRepository.new(csv_path)
      expect(repo.all).to be_a(Array)
      expect(repo.all[0].name).to eq("Green Tea")
    end
  end

  describe "#find" do
    it "should retrieve a specific product based on its id" do
      repo = ProductRepository.new(csv_path)
      product = repo.find(3)
      expect(product.id).to eq(3)
      expect(product.name).to eq("Coffee")
    end
  end
end
