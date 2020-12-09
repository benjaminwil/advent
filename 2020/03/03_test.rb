require "minitest/autorun"
require_relative "./03"

describe Traversal do
  let(:input) { <<-TXT
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
TXT
  }

  describe "trees_encountered" do
    let(:subject) { Traversal.trees_encountered(input, slope: slope) }
    describe "default slope" do
      let(:slope) { [3, 1] }

      it "counts encountered trees" do
        _(subject).must_equal 7
      end
    end

    describe "slope 1, 1" do
      let(:slope) { [1, 1] }

      it "counts encountered trees" do
        _(subject).must_equal 2
      end
    end
    describe "slope 7, 1" do
      let(:slope) { [5, 1] }

      it "counts encountered trees" do
        _(subject).must_equal 3
      end
    end

    describe "slope 7, 1" do
      let(:slope) { [7, 1] }

      it "counts encountered trees" do
        _(subject).must_equal 4
      end
    end

    describe "slope 1, 2" do
      let(:slope) { [1, 2] }

      it "counts encountered trees" do
        _(subject).must_equal 2
      end
    end
  end

  describe "all_routes" do
    let(:subject) { Traversal.all_routes(input, slopes: slopes) }
    let(:slopes) {
      [[3, 1], [1, 1], [5, 1], [7, 1], [1, 2]]
    }

    it "multiplies all trees encountered" do
      _(subject).must_equal 336
    end
  end
end
