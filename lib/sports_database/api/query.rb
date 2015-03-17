module SportsDatabase
  module Api
    module Query

      # Performs the desired query agains the Sports Database api
      #
      # @example:
      #   client.query("full name,school name,team,o:team,points,o:points@season=2014 and team=PURD")
      #   or
      #   client.query("full name,school name,team,o:team,points,o:points", "season=2014 and team=PURD")
      #   or
      #   client.query(["full name", "school name", "team", "o:team", "points", "o:points"], ["season=2014", "team=PURD"])
      #
      # @param [String], the sdb query
      # or
      # @param [Array/String], takes an array or string of selectors
      # @param [Array/String], takes an array or string of tables and conditions
      #
      # @return [Result]
      def query(*query)
        get(formatted_query(query))
      end

      private

      def formatted_query(query)
        raise ArgumentError, "Must have 1 or 2 arguments" if query.nil? || query.size > 2

        select = parse_query(query, 0)
        tables_and_conditions = parse_query(query, 1)

        format_query(select, tables_and_conditions)
      end

      def parse_query(query, index)
        if query.size == 1
          query[0].split("@")[index] || ""
        else
          query[index]
        end
      end

      def format_query(select, tables_and_conditions)
        if tables_and_conditions.nil? || tables_and_conditions == [] || (tables_and_conditions.is_a?(String) && tables_and_conditions.strip == "")
          select(select)
        else
          "#{select(select)}@#{tables_and_conditions(tables_and_conditions)}"
        end
      end

      def tables_and_conditions(tables_and_conditions)
        if tables_and_conditions.is_a?(Array)
          tables_and_conditions.map(&:strip).join(" and ").split("=").map(&:strip).join("=")
        else
          tables_and_conditions.split("=").map(&:strip).join("=")
        end
      end

      def select(select)
        if select.is_a?(Array)
          select.map(&:strip).join(",")
        else
          select.split(",").map(&:strip).join(",")
        end
      end

    end
  end
end
