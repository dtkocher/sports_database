module SportsDatabase
  module Api
    module Query
      attr_accessor :tables_and_conditions, :select, :query_string
      attr_reader :connection, :response

      def query
        @response = conn.get do |resp|
          resp.params[:sdql] = query_string
          resp.params[:output] = "json"
          resp.params[:api_key] = api_key
        end
      end

      private

      def tables_and_conditions=(tables_and_conditions)
        if tables_and_conditions.is_a?(Array)
          @tables_and_conditions = tables_and_conditions.map(&:strip).join(" and ").split("=").map(&:strip).join("=")
        else
          @tables_and_conditions = tables_and_conditions.split("=").map(&:strip).join("=")
        end
      end

      def select=(select)
        if select.is_a?(Array)
          @select = selecting.map(&:strip).join(",")
        else
          @select = selecting.split(",").map(&:strip).join(",")
        end
      end

      def query_string=(query_string)
        if query_string.nil?
          @query_string = (table_and_conditions=="" ? select : "#{select}@#{table_and_conditions}")
        else
          self.select = query_string.split("@").first || ""
          self.tables_and_conditions = query_string.split("@").last || ""
          @query_string = (table_and_conditions=="" ? select : "#{select}@#{table_and_conditions}")
        end
      end
    end
  end
end
