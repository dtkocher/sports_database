require 'faraday_middleware'
require 'faraday_middleware/response_middleware'
require 'typhoeus/adapters/faraday'
require 'typhoeus'
require 'json'

module SportsDatabase
  autoload :Client, 'sports_database/client'
  autoload :Api, 'sports_database/api'
  autoload :Helpers, 'sports_database/helpers'
  autoload :VERSION, 'sports_database/version'
end
