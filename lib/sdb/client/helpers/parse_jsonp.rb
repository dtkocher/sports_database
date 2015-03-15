module SDB
  module Client
    module Helpers
      class ParseJsonp < FaradayMiddleware::ParseJson

        define_parser do |body|
          JSON.parse body[/{.+}/].gsub("'", "\"") unless body.strip.empty?
        end

      end
    end
  end
end
