require "minitest/autorun"
require_relative "./07"

describe Crabmarine do
  let(:file) {
    <<~INPUT
      16,1,2,0,4,2,7,1,2,14
    INPUT
  }

  describe "part 1" do
    let(:subject) { Crabmarine.new(input: file).cheapest }

    it "calculates the least amount of fuel for alignment" do
      _(subject).must_equal 37
    end
  end

  describe "part 2" do
    let(:subject) { Crabmarine.new(input: file).cheapest(:n_plus_i) }

    it "calculates the least amount of fuel for alignment" do
      _(subject).must_equal 168
    end
  end
end

