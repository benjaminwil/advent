require "minitest/autorun"
require_relative "./08"

describe Boot do
  let(:boot) { Boot.new(input) }
  let(:input) {
    <<~TXT
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    TXT
  }

  describe "sequence" do
    let(:subject) { boot.sequence }

    it "converts instructions to structured data" do
      _(subject.first).must_equal({
        id: 0, op: 'nop', arg: 0
      })
    end
  end

  describe "run_until_true" do
    let(:subject) { boot.run_until_true }

    it "returns only a complete run after testing for bugs" do
      _(subject).must_equal [true, 8]
    end
  end

  describe "run_once" do
    let(:subject) { boot.run_once }

    it "returns last accumulator value before second run" do
      _(subject).must_equal [false, 5]
    end
  end
end

