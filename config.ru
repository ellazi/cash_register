require './app'
require 'rack/cors'

run Sinatra::Application


use Rack::Cors do
  allow do
    origins 'http://localhost:3000'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options] 
  end
end
