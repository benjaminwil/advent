require "minitest/autorun"
require_relative "./05"

describe Seats do
  let(:seats) { Seats.new(input) }

  describe "parse" do
    let(:subject) { seats.parse }
    let(:input) { ["BFFFBBFRRR"] }

    it "gets the correct seat" do
      _(subject).must_equal([{
        row: 70,
        col: 7,
        id: 567
      }])
    end
  end
end
