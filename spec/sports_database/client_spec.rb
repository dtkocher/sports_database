require 'spec_helper'

describe SportsDatabase do
  it 'has a version number' do
    expect(SportsDatabase::VERSION).not_to be nil
  end

  describe "integration test" do
    subject { SportsDatabase::Client.new(parameters) }
    let(:parameters) { {} }

    context "Client class" do
      context "defaults" do
        it { expect(subject.sport).to eq("ncaabb") }
        it { expect(subject.api_key).to eq("guest") }
      end

      context "with params" do
        let(:parameters) { {sport: "ncaafb", api_key: "test"} }
        it { expect(subject.sport).to eq("ncaafb") }
        it { expect(subject.api_key).to eq("test") }
      end
    end

    context "Query module" do
      context "mock" do
        let(:response) { Faraday::Response.new(status: code, body: body, response_headers: {'Content-Type' => 'application/json'}) }
        let(:body) { {} }
        let(:code) { 200 }
        let(:result) { subject.query("team, o:team@season = 2014 and team = PURD") }

        before { subject.stub(:get) { SportsDatabase::Helpers::Result.new response } }

        it { expect(result.class).to eq(SportsDatabase::Helpers::Result) }

        context "invalid return" do
          let(:code) { 401 }

          it { expect(result.success?).to be_falsey }
          it { expect(result.fail?).to be_truthy }
          it { expect(result.status_code).to eq(401) }
        end

        context "valid return" do
          let(:code) { 200 }

          context "no data" do
            it { expect(result.success?).to be_truthy }
            it { expect(result.status_code).to eq(200) }
            it { expect(result.data).to eq([]) }
            it { expect(result.raw_response).to eq(response) }
          end

          context "data" do
            let(:body) do
              {"headers"=>["team", "o:team"],
               "groups"=>[{"sdql"=>"season = 2014 and team = PURD",
                "columns"=>[["PURD", "PURD", "PURD", "PURD"],["SAM", "INDPU", "GRAMB", "KANST"]]}]}
            end

            it { expect(result.success?).to be_truthy }
            it { expect(result.status_code).to eq(200) }
            it { expect(result.raw_response).to eq(response) }
            it do
              expected = [{group: "season = 2014 and team = PURD",
                            data_set: [{:team=>"PURD", :o_team=>"SAM"},
                                         {:team=>"PURD", :o_team=>"INDPU"},
                                         {:team=>"PURD", :o_team=>"GRAMB"},
                                         {:team=>"PURD", :o_team=>"KANST"}]}]
              expect(result.data).to eq(expected)
            end
          end
        end
      end
      context "real" do
        let(:parameters) { {sport: "nfl"} }
        let(:result) { subject.query("date,points,o:points@team=Bears and season=2011 and site") }

        it do
          expect(result.status_code).to eq(200)
          expect(result.success?).to be_truthy

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
          expect(result.data).to eq(expected)
        end
      end
    end
  end
end
