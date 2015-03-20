require 'spec_helper'

describe SportsDatabase::Helpers::Result do

  describe "#intialize" do
    subject { SportsDatabase::Helpers::Result.new(response) }
    let(:response) { Faraday::Response.new(status: code, body: body, response_headers: {'Content-Type' => 'application/json'}) }
    let(:body) { {} }

    context "unsuccessful response" do
      let(:code) { 401 }

      it { expect(subject.success?).to be_falsey }
      it { expect(subject.fail?).to be_truthy }
      it { expect(subject.status_code).to eq(401) }
    end

    context "successful response" do
      let(:code) { 200 }
      it { expect(subject.success?).to be_truthy }
      it { expect(subject.status_code).to eq(200) }
      it { expect(subject.data).to eq([]) }


      context "response body contains one group" do
        let(:body) do
          {"headers"=>["team", "o:team"],
           "groups"=>[{"sdql"=>"season = 2014 and team = PURD",
                        "columns"=>[["PURD", "PURD", "PURD", "PURD"],["SAM", "INDPU", "GRAMB", "KANST"]]}]}
        end

        it do
          expected = [{group: "season = 2014 and team = PURD",
                        data_set: [{:team=>"PURD", :o_team=>"SAM"},
                                     {:team=>"PURD", :o_team=>"INDPU"},
                                     {:team=>"PURD", :o_team=>"GRAMB"},
                                     {:team=>"PURD", :o_team=>"KANST"}]}]
          expect(subject.data).to eq(expected)
        end
      end

      context "response body conatins two groups" do
        let(:body) do
          {"headers"=>['date', 'points', 'o:points'],
            "groups"=>[{ "sdql"=>"team = Bears and season = 2011 and site = home" ,
            "columns"=>[ [20110911,20110925,20111002,20111016,20111113,20111120,20111204,20111218],
                          [30,17,34,39,37,31,3,14], [12,27,29,10,13,20,10,38] ]},
              { "sdql"=>"team = Bears and season = 2011 and site = away" ,
             "columns"=>[ [20110918,20111010,20111023,20111107,20111127,20111211,20111225,20120101],
                          [13,13,24,30,20,10,21,17],
                          [30,24,18,24,25,13,35,13] ]} ] }
        end

        it do
          expected = [{:group=>"team = Bears and season = 2011 and site = home",
                        :data_set=>[{:date=>20110911, :points=>30, :o_points=>12},
                                  {:date=>20110925, :points=>17, :o_points=>27},
                                  {:date=>20111002, :points=>34, :o_points=>29},
                                  {:date=>20111016, :points=>39, :o_points=>10},
                                  {:date=>20111113, :points=>37, :o_points=>13},
                                  {:date=>20111120, :points=>31, :o_points=>20},
                                  {:date=>20111204, :points=>3, :o_points=>10},
                                  {:date=>20111218, :points=>14, :o_points=>38}]},
                        {:group=>"team = Bears and season = 2011 and site = away",
                          :data_set=>[{:date=>20110918, :points=>13, :o_points=>30},
                                   {:date=>20111010, :points=>13, :o_points=>24},
                                   {:date=>20111023, :points=>24, :o_points=>18},
                                   {:date=>20111107, :points=>30, :o_points=>24},
                                   {:date=>20111127, :points=>20, :o_points=>25},
                                   {:date=>20111211, :points=>10, :o_points=>13},
                                   {:date=>20111225, :points=>21, :o_points=>35},
                                   {:date=>20120101, :points=>17, :o_points=>13}]}]
          expect(subject.data).to eq(expected)
        end
      end
    end
  end
end
