module SportsDatabase
  module Helpers
    class Result
      attr_reader :raw_response, :data

      def initialize(response)
        @raw_response = response
        generate(response.body)
      end

      def status
        raw_response.status
      end

      def success?
        raw_response.success?
      end

      def fail?
        !success?
      end

      private

      def generate(body)
        @data = {} unless success? && !body.nil? && !body.empty?


      end
    end
  end
end
