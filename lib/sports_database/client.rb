require 'faraday_middleware'
require 'typhoeus'

module SportsDatabase
  class Client
    include Api::Query

    attr_accessor :api_key
    attr_reader :connection

    def initialize(opts={})
      self.api_key = opts.fetch(:api_key, "guest")
      connection
    end

    private

    def connection(opts={})
      @connection = Faraday.new(url: "http://api.sportsdatabase.com/#{opts.fetch(:sport, "ncaabb")}/query.json") do |config|
        config.request :url_encoded
        config.adapter  :typhoeus
        config.use Helpers::ParseJsonp
      end
    end
  end
end
