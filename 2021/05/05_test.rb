require "minitest/autorun"
require_relative "./05"

describe Overlap do
  let(:file) {
    <<~INPUT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
  }

  describe "part 1" do
    let(:subject) { Overlap.new(input: file).simple }

    it "counts number of points where two lines overlap" do
      _(subject).must_equal 5
    end
  end

  describe "part 2" do
    let(:subject) { Overlap.new(input: file).complex }

    it "counts number of points where two lines overlap" do
      _(subject).must_equal 12
    end
  end
end

