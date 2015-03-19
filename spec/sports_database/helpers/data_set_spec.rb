require 'spec_helper'

describe SportsDatabase::Helpers::DataSet do
  subject do
    DataSet = SportsDatabase::Helpers::DataSet.create(column_names)
    DataSet.new
  end

  describe "#create" do
    subject { SportsDatabase::Helpers::DataSet.create(column_names) }

    context "invalid" do
      context "pass in nil" do
        let(:column_names) { nil }
        it { expect{subject}.to raise_error(ArgumentError, "Must pass in none empty array") }
      end

      context "pass in none array" do
        let(:column_names) { "string" }
        it { expect{subject}.to raise_error(ArgumentError, "Must pass in none empty array") }
      end

      context "pass in empty array" do
        let(:column_names) { [] }
        it { expect{subject}.to raise_error(ArgumentError, "Must pass in none empty array") }
      end

      context "pass in nil in the array" do
        let(:column_names) { ["first", nil, "third"] }
        it { expect{subject}.to raise_error(ArgumentError, "Must be a valid string") }
      end

      context "pass in empty string in the array" do
        let(:column_names) { ["first", "", "third"] }
        it { expect{subject}.to raise_error(ArgumentError, "Must be a valid string") }
      end
    end

    context "valid" do
      let(:column_names) { ["first", "second", "third"] }
      it { expect(subject.class).to eq(Class) }
      it { expect(subject.column_names).to eq([:first, :second, :third]) }
    end
  end

  describe "#get(column_name)" do
    let(:column_names) { ["first", "second", "third"] }
    before { subject.first = "1" }

    it { expect(subject.first).to eq("1") }
    it { expect(subject.get("first")).to eq(subject.first) }
  end

  describe "#set(column_name, value)" do
    let(:column_names) { ["first", "second", "third"] }
    before { subject.set("first", 123) }

    it { expect(subject.get("first")).to eq(123) }
  end

  describe "#to_hash" do
    let(:column_names) { ["first", "second", "third"] }
    before do
      subject.set("first", 123)
      subject.set("second", 1122)
      subject.set("third", 3)
    end

    it { expect(subject.to_hash).to eq({first: 123, second: 1122, third: 3}) }
  end
end
