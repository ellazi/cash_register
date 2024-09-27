require 'sinatra'
require 'rack/cors'
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
