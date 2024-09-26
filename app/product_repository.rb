class ProductRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @products = []
    @next_id = 1
    load_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_f
      @products << Product.new({ id: row[:id], product_code: row[:product_code], name: row[:name], price: row[:price], discount: row[:discount] })
    end
    @next_id = @products.empty? ? 1 : @products.last.id + 1
  end
end
