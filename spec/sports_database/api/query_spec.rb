require 'spec_helper'

describe SportsDatabase::Api::Query do
  subject { Class.new { include SportsDatabase::Api::Query }.new }

  describe "#formatted_query(query)" do
    context "query = nil" do
      let(:query) { nil }
      it { expect{subject.send(:formatted_query, query)}.to raise_error(ArgumentError, "Must have 1 or 2 arguments") }
    end

    context "query = 'one', two, 'three' " do
      let(:query) { ['one', 'two', 'three'] }
      it { expect{subject.send(:formatted_query, query)}.to raise_error(ArgumentError, "Must have 1 or 2 arguments") }
    end

    context "query = 'team, full name @ team = PURD'" do
      let(:query) { ['team, full name @ team = PURD'] }
      it { expect(subject.send(:formatted_query, query)).to eq(query.first) }
    end

    context "query = 'team, full name', 'team = PURD'" do
      let(:query) { ['team, full name', 'team = PURD'] }
      it { expect(subject.send(:formatted_query, query)).to eq(query.join("@")) }
    end
  end

end
