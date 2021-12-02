require "minitest/autorun"
require_relative "./02"

describe Position do
  let(:file) {
    <<~INPUT
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    INPUT
  }

  describe "result" do
    let(:subject) { Position.result(input: file) }

    it "returns the coordinates multiplied" do
      _(subject).must_equal 150
    end
  end

  describe "result2" do
    let(:subject) { Position.result2(input: file) }

    it "returns the coordinates multiplied" do
      _(subject).must_equal 900
    end
  end
end
