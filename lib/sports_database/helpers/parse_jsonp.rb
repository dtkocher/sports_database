require 'faraday_middleware/response_middleware'
require 'json'

module SportsDatabase
  module Helpers
    class ParseJsonp < FaradayMiddleware::ParseJson

      define_parser do |body|
        unless body.strip.empty? || body[/{.+}/].nil?
          JSON.parse body[/{.+}/].gsub("'", "\"")
        end
      end

    end
  end
end
