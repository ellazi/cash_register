require 'sinatra'
require 'rack/cors'
require 'json'
require_relative "app/product_repository"
require_relative "app/products_controller"

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options, :head]
  end
end

get '/api/data' do
  content_type :json
  { message: 'Hello from Sinatra!' }.to_json
end

csv_file = File.join(__dir__, 'data/products.csv')
product_repository = ProductRepository.new(csv_file)
products_controller = ProductsController.new(product_repository)

# from product repository
get '/api/products' do
  content_type :json
  products = product_repository.all
  products.map { |product| { id: product.id, product_code: product.product_code, name: product.name, price: product.price } }.to_json
end

get '/api/products/:id' do
  content_type :json
  product = product_repository.find(params[:id])
  if product
    product.to_json
  else
    status 404
  end
end

# from products controller
post  '/api/add' do
  content_type :json
  product_data = JSON.parse(request.body.read)
  added_product = products_controller.add(product_data)
  status 201
  added_product.to_json
end

# get '/api/list' do
#   content_type :json
#   products_list = products_controller.list
#   products_list.to_json
# end

post '/api/checkout' do
  content_type :json
  products_checkout = products_controller.checkout
  products_checkout.to_json
end
