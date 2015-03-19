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

=begin
  {"headers"=>["full name", "school name", "team", "o:team", "points", "o:points"],
    "groups"=>[{"sdql"=>"season = 2014 and team = PURD",
    "columns"=>[["Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", "Purdue Boilermakers", nil],
                ["Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", "Purdue", nil],
                ["PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD", "PURD"],
                ["SAM", "INDPU", "GRAMB", "KANST", "MISSO", "BYU", "NCSTA", "NFLA", "IUPU", "ARKST", "VANDY", "NOTRE", "GARDW", "MIN", "MICH", "WISC", "MARY", "PENST", "ILL", "IOWA", "IND", "NWEST", "OHIOS", "MIN", "RUTG", "NEB", "IND", "RUTG", "OHIOS", "MCHST", "ILL", "PENST", "WISC", "CIN"],
                [80, 77, 82, 79, 82, 87, 66, 70, 63, 87, 71, 63, 84, 72, 64, 55, 60, 84, 57, 67, 83, 68, 60, 58, 61, 66, 67, 92, 61, 66, 63, 64, 51, nil],
                [40, 57, 30, 88, 61, 85, 61, 73, 43, 46, 81, 94, 89, 68, 51, 62, 69, 77, 66, 63, 67, 60, 58, 62, 51, 54, 63, 85, 65, 72, 58, 59, 71, nil]]}]}


or


  { "headers"=>['date', 'points', 'o:points'],
    "groups"=>[{ "sdql"=>"team = Bears and season = 2011 and site = home" ,
    "columns"=>[ [20110911,20110925,20111002,20111016,20111113,20111120,20111204,20111218],
                  [30,17,34,39,37,31,3,14],
                  [12,27,29,10,13,20,10,38] ]},
              { "sdql"=>"team = Bears and season = 2011 and site = away" ,
    "columns"=>[ [20110918,20111010,20111023,20111107,20111127,20111211,20111225,20120101],
                  [13,13,24,30,20,10,21,17],
                  [30,24,18,24,25,13,35,13] ]} ] }
=end
      def generate(body)
        return true unless success? && !body.nil? && !body.empty?

        data = DataSet.new(body["headers"])


      end
    end
  end
end
