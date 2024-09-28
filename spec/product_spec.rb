require_relative '../app/models/product'

RSpec.describe Product do
  it 'creates a product class' do
    product = Product.new
    expect(product).to be_kind_of(Product)
  end

  describe '#initialize' do
    it 'should have a name' do
      product = Product.new
      expect(product).to respond_to :name
    end

    it 'should have a product_code' do
      product = Product.new
      expect(product).to respond_to :product_code
    end

    it 'should have a price' do
      product = Product.new
      expect(product).to respond_to :price
    end
  end
end
