require 'sinatra'
require 'rack/cors'
require 'json'
require_relative "./app/repositories/product_repository"
require_relative "./app/controllers/products_controller"

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

# From product repository
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

# From products controller
post  '/api/add' do
  content_type :json
  product_data = JSON.parse(request.body.read)
  puts "Received product data: #{product_data.inspect}"
  added_product = products_controller.add_frontend(product_data)
  status 201
  added_product.to_json
end

post '/api/checkout' do
  content_type :json
  cart_data = JSON.parse(request.body.read)
  puts "Received product data: #{cart_data.inspect}"
  cart_data = cart_data.map { |product_data| product_repository.find(product_data['id']) }
  array = products_controller.checkout_frontend(cart_data)
  { basket: array[0], total_price: array[1] }.to_json
end
