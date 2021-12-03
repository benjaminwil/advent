require "minitest/autorun"
require_relative "./03"

describe Diagnostic do
  let(:file) {
    <<~INPUT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  }

  describe "consumption" do
    let(:subject) { Diagnostic.consumption(input: file) }

    it "is a number" do
      _(subject).must_equal 198
    end
  end


  describe "life_support_rating" do
    let(:subject) { Diagnostic.rating(input: file) }
    it "is a number" do
      _(subject).must_equal 230
    end
  end
end
