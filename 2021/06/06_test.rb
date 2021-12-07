require "minitest/autorun"
require_relative "./06"

describe Lanternfish do
  let(:file) {
    <<~INPUT
      3,4,3,1,2
    INPUT
  }

  describe "#population(days: 18)" do
    let(:subject) { Lanternfish.new(input: file).population(days: 18) }

    it "counts the amount of fish after 18 days" do
      _(subject).must_equal 26
    end
  end

  describe "#population(days: 80)" do
    let(:subject) { Lanternfish.new(input: file).population(days: 80) }

    it "counts the amount of fish after 80 days" do
      _(subject).must_equal 5934
    end
  end

  describe "#population(days: 256)" do
    let(:subject) { Lanternfish.new(input: file).population(days: 256) }

    it "counts the amount of fish after 256 days" do
      _(subject).must_equal 26984457539
    end
  end
end

