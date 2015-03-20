module SportsDatabase
  module Helpers
    class Result

      attr_reader :raw_response, :data

      def initialize(response)
        @raw_response = response
        @data = []
        generate_data(response.body)
      end

      def status_code
        raw_response.status
      end

      def success?
        raw_response.success?
      end

      def fail?
        !success?
      end

      private

      # Parases through the response body and creates nicer ruby loved hash
      #
      # @param [Hash], the sdb query
      #                    {"headers"=>["team", "o:team"],
      #                        "groups"=>[{"sdql"=>"season = 2014 and team = PURD",
      #                        "columns"=>[["PURD", "PURD", "PURD", "PURD"],
      #                                    ["SAM", "INDPU", "GRAMB", "KANST"]]}]}
      #                 or
      #                     {"headers"=>['date', 'points', 'o:points'],
      #                         "groups"=>[{ "sdql"=>"team = Bears and season = 2011 and site = home" ,
      #                         "columns"=>[ [20110911,20110925,20111002,20111016,20111113,20111120,20111204,20111218],
      #                                       [30,17,34,39,37,31,3,14], [12,27,29,10,13,20,10,38] ]},
      #                                       { "sdql"=>"team = Bears and season = 2011 and site = away" ,
      #                          "columns"=>[ [20110918,20111010,20111023,20111107,20111127,20111211,20111225,20120101],
      #                                       [13,13,24,30,20,10,21,17],
      #                                       [30,24,18,24,25,13,35,13] ]} ] }
      #
      # @return []
      def generate_data(body)
        return true unless success? && !body.nil? && !body.empty?

        klass = DataSet.create(body["headers"])
        body["groups"].each do |group|
          @data << { group: group["sdql"], data_set: format_data_set(klass, group["columns"], body["headers"]) }
        end
      end

      def format_data_set(klass, columns, column_names)
        data_sets = []

        # loop through the first column to get row num
        # then loop through each column num
        # then grab that columns row and set it in the data set object
        # and create the data set
        columns[0].each_with_index do |row, row_num|
          data_set = klass.new
          (0..(column_names.size-1)).each do |column_num|
            data_set.set(column_names[column_num], columns[column_num][row_num])
          end
          data_sets << data_set.to_hash
        end

        data_sets
      end
    end
  end
end
