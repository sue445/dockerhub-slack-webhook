ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "rollbar/middleware/sinatra"

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  get "/" do
    "It works"
  end
end
