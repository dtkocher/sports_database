require 'faraday_middleware'
require 'typhoeus/adapters/faraday'
require 'typhoeus'

module SportsDatabase
  module Helpers
    module Connection

      private

      attr_reader :response

      def connection
        @connection ||=
          Faraday.new(url: "http://api.sportsdatabase.com/#{sport}/query.json") do |config|
            config.request :url_encoded
            config.adapter  :typhoeus
            config.use ParseJsonp
          end
      end

      def get(query)
        @response = connection.get do |request|
          request.params[:sdql] = query
          request.params[:output] = "json"
          request.params[:api_key] = api_key
        end
      end

      def status
        response.status
      end

      def success?
        response.success?
      end

      def fail?
        !success?
      end
    end
  end
end

