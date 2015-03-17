module SportsDatabase
  module Api
    module Query

      # Performs the desired query agains the Sports Database api
      #
      # @param [String], the sdb query
      # @return [Result]
      def query(query)
        get(formatted_query_string(query))
      end

      # Performs the desired query agains the Sports Database api
      #
      # @param [Array/String], takes an array or string of selectors
      # @param [Array/String], takes an array or string of tables and conditions
      # @return [Result]
      def query(select=[], tables_and_conditions=[])
        get(formatted_query_string(select, tables_and_conditions))
      end

      private

      def formatted_query_string(query_string)
        select = query_string.split("@").first || ""
        tables_and_conditions = query_string.split("@").last || ""
        formatted_query_string(select(select), table_and_conditions(tables_and_conditions))
      end

      def formatted_query_string(select, tables_and_conditions)
        if tables_and_conditions == [] || (tables_and_conditions.is_a?(String) && table_and_conditions.strip == "")
          select(select)
        else
          "#{select(select)}@#{table_and_conditions(tables_and_conditions)}"
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
          selecting.map(&:strip).join(",")
        else
          selecting.split(",").map(&:strip).join(",")
        end
      end

    end
  end
end
