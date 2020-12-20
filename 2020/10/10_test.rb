require "minitest/autorun"
require "./10"

describe Joltage do
  let(:joltage) { Joltage.new(input) }
  let(:input) {
    <<~TXT
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    TXT
  }

  describe "differences" do
    let(:subject) { joltage.differences }

    it "lists differences of 1 and 3 jolts" do
      _(subject).must_equal({
        one: 22,
        three: 10
      })
    end
  end

  describe "arrangements" do
    let(:subject) { joltage.arrangements }

    it "returns the number of combinations that are acceptable" do
      _(subject).must_equal 19208
    end
  end
end
