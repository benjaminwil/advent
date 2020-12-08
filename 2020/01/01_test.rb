require "minitest/autorun"
require_relative "./01"

describe Entries do
  let(:input) { [1721, 979, 366, 299, 675, 1456] }

  describe "find_pair" do
    let(:subject) { Entries.find_pair(input) }

    it "gets the entries that sum 2020" do
      _(subject).must_equal [299, 1721]
    end
  end

  describe "find_trio" do
    let(:subject) { Entries.find_trio(input) }

    it "gets the entries that sum 2020" do
      _(subject).must_equal [366, 675, 979]
    end
  end

  describe "answer (pair)" do
    let(:subject) { Entries.answer(input: input) }

    it "multiplies found entries" do
      _(subject).must_equal 299 * 1721
    end
  end

  describe "answer (trio)" do
    let(:subject) { Entries.answer(input: input, method: :find_trio) }

    it "multiplies found entries" do
      _(subject).must_equal 366 * 675 * 979
    end
  end
end
