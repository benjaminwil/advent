require "minitest/autorun"
require_relative "./06"

describe Declaration do
  let(:declaration) { Declaration.new(input) }
  let(:input) {
    <<~TXT
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    TXT
  }

  describe "unique" do
    let(:subject) { declaration.unique }

    it "counts unique answers" do
      _(subject).must_equal 11
    end
  end

  describe "consensus" do
    let(:subject) { declaration.consensus }

    it "counts answers where group has consensus" do
      _(subject).must_equal 6
    end
  end
end
