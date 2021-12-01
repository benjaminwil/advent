require "minitest/autorun"
require_relative "./01"

describe Depth do
  let(:file) {
    <<~INPUT
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    INPUT
  }

  describe "result" do
    let(:subject) { Depth.increases(input: file) }

    it "returns the number of increases in depth" do
      _(subject).must_equal 7
    end
  end

  describe "sliding" do
    let(:subject) { Depth.sliding(input: file) }

    it "returns the number of groups of three that increase in depth" do
      _(subject).must_equal 5
    end
  end
end
