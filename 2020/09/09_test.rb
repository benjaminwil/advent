require "minitest/autorun"
require_relative "./09"


describe Preamble do
  let(:preamble) { Preamble.new(input) }
  let(:input) {
    <<~TXT
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    TXT
  }

  describe "first_invalid_entry" do
    let(:subject) { preamble.first_invalid_entry(limit: 5) }

    it "finds first invalid entry" do
      _(subject).must_equal 127
    end
  end

  describe "weak_range" do
    let(:subject) { preamble.weak_range(limit: 5) }

    it "gets a list of entries that equal the first invalid entry if summed" do
      _(subject).must_equal [15, 25, 47, 40]
    end
  end
end

