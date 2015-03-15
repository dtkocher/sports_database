module SDB
  module Client
    module Helpers
      module Connection

        def self.connection(opts={})
          conn = Faraday.new(url: "http://api.sportsdatabase.com/#{opts.fetch(:sport, "ncaabb")}/query.json") do |config|
            config.request :url_encoded
            config.adapter  :typhoeus
            config.use ParseJsonp
          end
        end

      end
    end
  end
end
