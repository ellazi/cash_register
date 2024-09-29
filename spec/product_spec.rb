require_relative '../app/models/product'

RSpec.describe Product do
  let(:product) { Product.new }

  it 'creates a product class' do
    expect(product).to be_kind_of(Product)
  end

  describe '#initialize' do
    it 'should have a name' do
      expect(product).to respond_to :name
    end

    it 'should have a product_code' do
      expect(product).to respond_to :product_code
    end

    it 'should have a price' do
      expect(product).to respond_to :price
    end
  end
end
