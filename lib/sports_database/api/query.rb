module SportsDatabase
  module Api
    module Query

      # Performs the desired query agains the Sports Database api
      #
      # @example:
      #   client.query("full name,team@season=2014 and team=PURD")
      #   or
      #   client.query("full name,team", "season=2014 and team=PURD")
      #
      # @param [String], the sdb query
      # or
      # @param [String], the select portion
      # @param [String], the table and condition portion
      #
      # @return [Result]
      def query(*query)
        get(formatted_query(query))
      end

      private

      def formatted_query(query)
        raise ArgumentError, "Must have 1 or 2 arguments" if query.nil? || query.size > 2
        query.join("@")
      end
    end
  end
end
